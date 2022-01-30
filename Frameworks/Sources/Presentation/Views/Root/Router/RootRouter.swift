//
//  RootRouter.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/30.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Application
import SwiftUI

/// 各タブのトップの画面のRouterプロパティを持つだけなので、RootRouterはRouterプロトコルに準拠しない
public final class RootRouter: ObservableObject {

  @ObservedObject private var store: RootStore
  let repoListRouter = RepoListRouterImpl(isPresented: .constant(false))
  let userListRouter = UserListRouterImpl(isPresented: .constant(false))

  public init(store: RootStore = .shared) {
    self.store = store
  }

  func deepLinkValueChanged() {
    switch store.deepLink {
    case .tab(let index):
      guard let tab = TabIdentifier(rawValue: index) else {
        return
      }
      // タブを選択
      store.activeTab = tab

    case .repo(let urlString):
      // Repositoriesタブを選択
      store.activeTab = .repositories
      // 指定タブのナビゲーションスタックのルートまでPopする
      popToRootView(tab: store.activeTab)
      // 遷移アニメーションが見えるようにするためdelayをかける
      DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(750)) { [weak self] in
        self?.repoListRouter.navigateToGeneralWebView(urlString: urlString)
      }

    case .user(let urlString):
      // Usersタブを選択
      store.activeTab = .users
      // 指定タブのナビゲーションスタックのルートまでPopする
      popToRootView(tab: store.activeTab)
      // 遷移アニメーションが見えるようにするためdelayをかける
      DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(750)) { [weak self] in
        self?.userListRouter.navigateToGeneralWebView(urlString: urlString)
      }
    case .none:
      print("Deeplink none.")
    }
  }

  private func popToRootView(tab: TabIdentifier) {
    guard
      let rootViewController = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController,
      let tabBarController = rootViewController.children.first as? UITabBarController,
      let navigationController = tabBarController.viewControllers?[safe: tab.rawValue]?.children.first as? UINavigationController
    else {
      return
    }
    navigationController.popToRootViewController(animated: true)
  }
}
