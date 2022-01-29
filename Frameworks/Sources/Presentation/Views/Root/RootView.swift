//
//  RootView.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

public struct RootView: View {

  public init() {}

  @State private var activeTab = TabIdentifier.repositories
  private let repoListRouter = RepoListRouterImpl(isPresented: .constant(false))
  private let userListRouter = UserListRouterImpl(isPresented: .constant(false))

  public var body: some View {
    TabView(selection: $activeTab) {
      RepoListView(router: repoListRouter)
        .tabItem {
          TabItemView(titleKey: "root_view.tab.repositories", systemImageName: "doc.text")
        }
        .tag(TabIdentifier.repositories)
      UserListView(router: userListRouter)
        .tabItem {
          TabItemView(titleKey: "root_view.tab.users", systemImageName: "person.fill")
        }
        .tag(TabIdentifier.users)
      LanguagesTabView()
        .tabItem {
          TabItemView(titleKey: "root_view.tab.languages", systemImageName: "text.magnifyingglass")
        }
        .tag(TabIdentifier.languages)
    }
    .onOpenURL(
      perform: { url in
        switch DeepLink(url: url) {
        case .tab(let index):
          guard let tab = TabIdentifier(rawValue: index) else {
            return
          }
          // タブを選択
          activeTab = tab

        case .repo(let urlString):
          // Searchタブを選択
          activeTab = .repositories
          // 指定タブのナビゲーションスタックのルートまでPopする
          popToRootView(tab: activeTab)
          // 遷移アニメーションが見えるようにするためdelayをかける
          DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(750)) {
            repoListRouter.navigateToGeneralWebView(urlString: urlString)
          }

        case .user(let urlString):
          // Userタブを選択
          activeTab = .users
          // 指定タブのナビゲーションスタックのルートまでPopする
          popToRootView(tab: activeTab)
          // 遷移アニメーションが見えるようにするためdelayをかける
          DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(750)) {
            userListRouter.navigateToGeneralWebView(urlString: urlString)
          }
        case .none:
          print("Deeplink none.")
        }
      }
    )
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

#if DEBUG
  struct RootView_Previews: PreviewProvider {
    static var previews: some View {
      AppPreview {
        RootView()
      }
    }
  }
#endif
