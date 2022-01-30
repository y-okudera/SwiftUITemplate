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

  func deepLinkValueChanged() async {
    defer {
      store.deepLink = nil
    }
    switch store.deepLink {
    case .tab(let index):
      guard let tab = TabIdentifier(rawValue: index) else {
        return
      }
      // モーダルビューがあれば閉じる
      await dismissAllModals()
      // タブを選択
      store.activeTab = tab

    case .repo(let urlString):
      // モーダルビューがあれば閉じる
      await dismissAllModals()
      // Repositoriesタブを選択
      store.activeTab = .repositories
      // RepositoriesタブのナビゲーションスタックのルートまでPopする
      popToRootView(tab: .repositories)
      // 遷移アニメーションが見えるようにするためdelayをかける
      DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(750)) { [weak self] in
        self?.repoListRouter.navigateToGeneralWebView(urlString: urlString)
      }

    case .user(let urlString):
      // モーダルビューがあれば閉じる
      await dismissAllModals()
      // Usersタブを選択
      store.activeTab = .users
      // UsersタブのナビゲーションスタックのルートまでPopする
      popToRootView(tab: .users)
      // 遷移アニメーションが見えるようにするためdelayをかける
      DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(750)) { [weak self] in
        self?.userListRouter.navigateToGeneralWebView(urlString: urlString)
      }
    case .none:
      print("Deeplink none.")
    }
  }
}

extension RootRouter {
  private var tabBarController: UITabBarController? {
    let rootViewController = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController
    return rootViewController?.children.first as? UITabBarController
  }

  private func dismissAllModals() async {
    await tabBarController?.dismiss(animated: true)
  }

  private func popToRootView(tab: TabIdentifier) {
    guard let navigationController = tabBarController?.viewControllers?[safe: tab.rawValue]?.children.first as? UINavigationController else {
      return
    }
    navigationController.popToRootViewController(animated: true)
  }
}
