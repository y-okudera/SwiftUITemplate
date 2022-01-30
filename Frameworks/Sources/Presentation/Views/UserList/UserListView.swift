//
//  UserListView.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Application
import SwiftUI

struct UserListView<R: UserListRouter>: View {
  @Environment(\.colorScheme) private var colorScheme
  @ObservedObject private var store: UserListStore
  @StateObject private var router: R

  @Injected(\.userListActionCreatorProvider)
  private var actionCreator: UserListActionCreatorProviding

  init(store: UserListStore = .shared, router: R) {
    self.store = store
    _router = StateObject(wrappedValue: router)
  }

  var body: some View {
    SearchNavigation(text: $store.inputText, search: { actionCreator.searchUsers(inputText: store.inputText) }) {
      List {
        ForEach(store.userAggregateRoot.users) { user in
          UserListRow(title: user.login, avatarUrl: user.avatarUrl) {
            router.navigateToGeneralWebView(urlString: user.htmlUrl.absoluteString)
          } imageAction: {
            router.presentUserDetailView(userID: user.id)
          }
        }
        HStack {
          Spacer()
          ProgressView()
            .onAppear {
              actionCreator.additionalSearchUsers(searchQuery: store.searchQuery, page: store.userAggregateRoot.page)
            }
          Spacer()
        }
        // 次のページがない場合、リスト末尾にインジケーターを表示しない
        .hidden(!store.userAggregateRoot.hasNext)
      }
      .alert(isPresented: $store.isErrorShown) { () -> Alert in
        Alert(title: Text(store.errorTitle), message: Text(store.errorMessage))
      }
      .navigationBarTitle(Text("user_list_view.navigation_bar_title.users", bundle: .current))
      .navigation(router)
      .sheet(router)
    }
    .edgesIgnoringSafeArea([.top, .bottom])
  }
}

#if DEBUG
  struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
      AppPreview {
        UserListView(
          store: .mock(mockAvatarUrl: resourceUrl(name: "octocat", ofType: "png")),
          router: UserListRouterImpl(isPresented: .constant(false))
        )
      }
    }
  }
#endif
