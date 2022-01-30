//
//  RootStore.swift
//  Application
//
//  Created by yuoku on 30/01/2022.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine

public final class RootStore: ObservableObject {
  public static let shared = RootStore()

  @Published public var deepLink: DeepLink?
  @Published public var activeTab: TabIdentifier = .repositories

  init(dispatcher: RootDispatcher = .shared) {
    dispatcher.register { [weak self] action in
      guard let self = self else { return }

      switch action {
      case .openURL(let deepLink):
        self.deepLink = deepLink
      }
    }
  }
}

// MARK: - Mock
#if DEBUG
  extension RootStore {
    public static var mock: Self {
      let mockStore = Self.init(dispatcher: .init())
      mockStore.deepLink = .init(url: URL(string: "gitHubApp://tab?index=2"))
      return mockStore
    }
  }
#endif
