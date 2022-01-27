//
//  SpecificLanguageRepoListStore.swift
//  Application
//
//  Created by okudera on 2022/01/20.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine
import Domain

public final class SpecificLanguageRepoListStore: ObservableObject {
  public static let shared = SpecificLanguageRepoListStore()

  /// 検索語
  @Published public var searchQuery = ""
  /// エラータイトル
  @Published public var errorTitle = ""
  /// エラーメッセージ
  @Published public var errorMessage = ""
  /// エラーダイアログトリガー
  @Published public var isErrorShown = false
  /// リポジトリ一覧
  @Published public private(set) var languagesRepoAggregateRoot = LanguagesRepoAggregateRoot()

  public init(dispatcher: SpecificLanguageRepoListDispatcher = .shared) {
    dispatcher.register { [weak self] action in
      guard let self = self else { return }

      switch action {
      case .updateRepoList(let newValue):
        self.languagesRepoAggregateRoot.set(newValue: newValue)
      case .updateErrorMessage(let title, let message):
        self.errorTitle = title
        self.errorMessage = message
      case .showError:
        self.isErrorShown = true
      }
    }
  }
}
