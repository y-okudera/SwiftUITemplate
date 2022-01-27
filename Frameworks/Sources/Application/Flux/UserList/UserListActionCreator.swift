//
//  UserListActionCreator.swift
//  Application
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine
import Domain

public final class UserListActionCreator {
  private let dispatcher: UserListDispatcher
  private let searchUsersSubject = PassthroughSubject<String, Never>()
  private let responseSubject = PassthroughSubject<UserAggregateRoot, Never>()
  private let additionalSearchUsersSubject = PassthroughSubject<(String, Int), Never>()
  private let additionalResponseSubject = PassthroughSubject<UserAggregateRoot, Never>()
  private let errorSubject = PassthroughSubject<APIError, Never>()

  private var cancellables: [AnyCancellable] = []

  @Injected(\.userRepositoryProvider)
  private var userRepository: UserRepositoryProviding

  public init(dispatcher: UserListDispatcher = .shared) {
    self.dispatcher = dispatcher
    bindData()
    bindActions()
  }

  func bindData() {
    // searchUsersSubjectにstringが送られてきたらAPIリクエストする
    let responseStream =
      searchUsersSubject
      .share()
      .map { [dispatcher] searchQuery in
        dispatcher.dispatch(.initializePage)
        return searchQuery
      }
      .flatMap { [userRepository] searchQuery in
        userRepository.response(searchQuery: searchQuery, page: 1)
          .catch { [weak self] apiError -> Empty<UserAggregateRoot, Never> in
            self?.errorSubject.send(apiError)
            return .init()
          }
      }
      .share()
      .subscribe(responseSubject)

    // additionalSearchUsersSubjectに(string, int)が送られてきたら追加読み込みのAPIリクエストする
    let additionalResponseStream =
      additionalSearchUsersSubject
      .share()
      .flatMap { [userRepository] searchQuery, page in
        userRepository.response(searchQuery: searchQuery, page: page)
          .catch { [weak self] apiError -> Empty<UserAggregateRoot, Never> in
            self?.errorSubject.send(apiError)
            return .init()
          }
      }
      .share()
      .subscribe(additionalResponseSubject)

    cancellables += [
      responseStream,
      additionalResponseStream,
    ]
  }

  func bindActions() {
    // ユーザー検索結果を反映
    let responseDataStream =
      responseSubject
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.updateUserList($0)) })

    // 検索結果が0件の場合、エラーメッセージを更新
    let emptyDataStream =
      responseSubject
      .filter { $0.users.isEmpty }
      .map { _ in ("検索結果", "該当するユーザーがいません。") }
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.updateErrorMessage($0.0, $0.1)) })

    // 検索結果が0件の場合、エラーメッセージを表示
    let isEmptyErrorStream =
      responseSubject
      .filter { $0.users.isEmpty }
      .map { _ in }
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.showError) })

    // 追加読み込み結果を反映
    let additionalResponseDataStream =
      additionalResponseSubject
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.updateUserList($0)) })

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
extension UserListActionCreator {

  public func searchUsers(searchQuery: String) {
    searchUsersSubject.send(searchQuery)
  }

  public func additionalSearchUsers(searchQuery: String, page: Int) {
    additionalSearchUsersSubject.send((searchQuery, page))
  }
}
