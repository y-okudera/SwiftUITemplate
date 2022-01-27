//
//  SpecificLanguageRepoListActionCreator.swift
//  Application
//
//  Created by okudera on 2022/01/20.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine
import Domain

public final class SpecificLanguageRepoListActionCreator {
  private let dispatcher: SpecificLanguageRepoListDispatcher
  private let searchRepositoriesSubject = PassthroughSubject<(String, Bool), Never>()
  private let responseSubject = PassthroughSubject<LanguagesRepoAggregateRoot, Never>()
  private let additionalSearchRepositoriesSubject = PassthroughSubject<(String, Int), Never>()
  private let additionalResponseSubject = PassthroughSubject<LanguagesRepoAggregateRoot, Never>()
  private let errorSubject = PassthroughSubject<APIError, Never>()

  private var cancellables: [AnyCancellable] = []

  @Injected(\.languagesRepoRepositoryProvider)
  private var languagesRepoRepository: LanguagesRepoRepositoryProviding

  public init(dispatcher: SpecificLanguageRepoListDispatcher = .shared) {
    self.dispatcher = dispatcher
    bindData()
    bindActions()
  }

  func bindData() {
    // searchRepositoriesSubjectにstringが送られてきたらAPIリクエストする
    let responseStream =
      searchRepositoriesSubject
      .filter { $1 }
      .map { [dispatcher] tuple -> String in
        let searchQuery = "language:\(tuple.0)"
        dispatcher.dispatch(.updateSearchQuery(searchQuery))
        return searchQuery
      }
      .share()
      .flatMap { [languagesRepoRepository] searchQuery in
        languagesRepoRepository.response(searchQuery: searchQuery, page: 1)
          .catch { [weak self] apiError -> Empty<LanguagesRepoAggregateRoot, Never> in
            self?.errorSubject.send(apiError)
            return .init()
          }
      }
      .share()
      .subscribe(responseSubject)

    // additionalSearchRepositoriesSubjectに(string, int)が送られてきたら追加読み込みのAPIリクエストする
    let additionalResponsePublisher =
      additionalSearchRepositoriesSubject.share()
      .flatMap { [languagesRepoRepository] searchQuery, page in
        languagesRepoRepository.response(searchQuery: searchQuery, page: page)
          .catch { [weak self] apiError -> Empty<LanguagesRepoAggregateRoot, Never> in
            self?.errorSubject.send(apiError)
            return .init()
          }
      }

    let additionalResponseStream =
      additionalResponsePublisher
      .share()
      .subscribe(additionalResponseSubject)

    cancellables += [
      responseStream,
      additionalResponseStream,
    ]
  }

  func bindActions() {
    // リポジトリ検索結果を反映
    let responseDataStream =
      responseSubject
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.updateRepoList($0)) })

    // 検索結果が0件の場合、エラーメッセージを更新
    let emptyDataStream =
      responseSubject
      .filter { $0.repositories.isEmpty }
      .map { _ in ("検索結果", "該当するリポジトリがありません。") }
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.updateErrorMessage($0.0, $0.1)) })

    // 検索結果が0件の場合、エラーメッセージを表示
    let isEmptyErrorStream =
      responseSubject
      .filter { $0.repositories.isEmpty }
      .map { _ in }
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.showError) })

    // 追加読み込み結果を反映
    let additionalResponseDataStream =
      additionalResponseSubject
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.updateRepoList($0)) })

    // errorSubjectにerrorが送られてきたら、エラーメッセージを更新
    let errorDataStream =
      errorSubject
      .map { error -> (String, String) in
        let nsError = error as NSError
        return (nsError.localizedDescription, (nsError.localizedRecoverySuggestion ?? "エラーが発生しました。"))
      }
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.updateErrorMessage($0.0, $0.1)) })

    // errorSubjectにerrorが送られてきたら、エラーメッセージを表示
    let errorStream =
      errorSubject
      .map { _ in }
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.showError) })

    cancellables += [
      responseDataStream,
      emptyDataStream,
      isEmptyErrorStream,
      additionalResponseDataStream,
      errorDataStream,
      errorStream,
    ]
  }
}

// MARK: - Input
extension SpecificLanguageRepoListActionCreator {

  public func onPageAppear(language: String, isEmpty: Bool) {
    searchRepositoriesSubject.send((language, isEmpty))
  }

  public func reachedBottom(searchQuery: String, page: Int) {
    additionalSearchRepositoriesSubject.send((searchQuery, page))
  }
}
