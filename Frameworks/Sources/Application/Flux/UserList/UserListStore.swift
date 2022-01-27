//
//  UserListStore.swift
//  Application
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine
import Domain

public final class UserListStore: ObservableObject {
  public static let shared = UserListStore()

  /// 検索語
  @Published public var searchQuery = ""
  /// エラータイトル
  @Published public var errorTitle = ""
  /// エラーメッセージ
  @Published public var errorMessage = ""
  /// エラーダイアログトリガー
  @Published public var isErrorShown = false
  /// リポジトリ一覧
  @Published public private(set) var userAggregateRoot = UserAggregateRoot()

  init(dispatcher: UserListDispatcher = .shared) {
    dispatcher.register { [weak self] action in
      guard let self = self else { return }

      switch action {
      case .initializePage:
        self.userAggregateRoot = .init()
      case .updateUserList(let newValue):
        self.userAggregateRoot.set(newValue: newValue)
      case .updateErrorMessage(let title, let message):
        self.errorTitle = title
        self.errorMessage = message
      case .showError:
        self.isErrorShown = true
      }
    }
  }
}

// MARK: - Mock
#if DEBUG
  extension UserListStore {
    public static func mock(mockAvatarUrl: URL) -> Self {
      let mockStore = Self.init(dispatcher: .init())
      mockStore.userAggregateRoot = .mock(mockAvatarUrl: mockAvatarUrl)
      return mockStore
    }
  }
#endif
