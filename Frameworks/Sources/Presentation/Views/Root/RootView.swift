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

  @State private var tabIndex: Int = 0
  private let repoListRouter = RepoListRouterImpl(isPresented: .constant(false))
  private let userListRouter = UserListRouterImpl(isPresented: .constant(false))

  public var body: some View {
    TabView(selection: $tabIndex) {
      RepoListView(router: repoListRouter)
        .tabItem {
          VStack {
            Image(systemName: "doc.text")
            Text("root_view.tab.repositories", bundle: .current)
          }
        }
        .tag(0)
      UserListView(router: userListRouter)
        .tabItem {
          VStack {
            Image(systemName: "person.fill")
            Text("root_view.tab.users", bundle: .current)
          }
        }
        .tag(1)
      LanguagesTabView()
        .tabItem {
          VStack {
            Image(systemName: "text.magnifyingglass")
            Text("root_view.tab.languages", bundle: .current)
          }
        }
        .tag(2)
    }
    .onOpenURL(
      perform: { url in
        switch Deeplink(url: url) {
        case .tab(let index):
          print("Deeplink .tab index=\(index)")
          // タブを選択
          tabIndex = index
        case .repo(let urlString):
          print("Deeplink .repo urlString=\(urlString)")
          // Searchタブを選択
          tabIndex = 0
          // 指定タブのナビゲーションスタックのルートまでPopする
          popToRootView(tabIndex: 0)
          // 遷移アニメーションが見えるようにするためdelayをかける
          DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(750)) {
            repoListRouter.navigateToGeneralWebView(urlString: urlString)
          }

        case .user(let urlString):
          print("Deeplink .user urlString=\(urlString)")
          // Userタブを選択
          tabIndex = 1
          // 指定タブのナビゲーションスタックのルートまでPopする
          popToRootView(tabIndex: 1)
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

  private func popToRootView(tabIndex: Int) {
    guard
      let rootViewController = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController,
      let tabBarController = rootViewController.children.first as? UITabBarController,
      let navigationController = tabBarController.viewControllers?[safe: tabIndex]?.children.first as? UINavigationController
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
