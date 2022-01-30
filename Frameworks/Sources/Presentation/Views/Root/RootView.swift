//
//  RootView.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Application
import SwiftUI

public struct RootView: View {
  @ObservedObject private var store: RootStore
  @ObservedObject private var router: RootRouter

  @Injected(\.rootActionCreatorProvider)
  private var actionCreator: RootActionCreatorProviding

  public init(store: RootStore = .shared, router: RootRouter = .init()) {
    self.store = store
    self.router = router
  }

  public var body: some View {
    TabView(selection: $store.activeTab) {
      RepoListView(router: router.repoListRouter)
        .tabItem {
          TabItemView(titleKey: "root_view.tab.repositories", systemImageName: "doc.text")
        }
        .tag(TabIdentifier.repositories)
      UserListView(router: router.userListRouter)
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
    .onOpenURL(perform: { actionCreator.openURL($0) })
    .onChange(of: store.deepLink) { _ in router.deepLinkValueChanged() }
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
