//
//  RepoListView.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/01.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Application
import SwiftUI

struct RepoListView<R: RepoListRouter>: View {
  @Environment(\.colorScheme) private var colorScheme
  @ObservedObject private var store: RepoListStore
  @StateObject private var router: R

  @Injected(\.repoListActionCreatorProvider)
  private var actionCreator: RepoListActionCreatorProviding

  init(store: RepoListStore = .shared, router: R) {
    self.store = store
    _router = StateObject(wrappedValue: router)
  }

  var body: some View {
    SearchNavigation(text: $store.inputText, search: { actionCreator.searchRepositories(inputText: store.inputText) }) {
      List {
        ForEach(store.repoAggregateRoot.repositories) { repository in
          RepoListRow(title: repository.fullName, language: repository.language ?? "") {
            router.navigateToGeneralWebView(urlString: repository.htmlUrl.absoluteString)
          }
        }
        HStack {
          Spacer()
          ProgressView()
            .onAppear {
              actionCreator.additionalSearchRepositories(searchQuery: store.searchQuery, page: store.repoAggregateRoot.page)
            }
          Spacer()
        }
        // 次のページがない場合、リスト末尾にインジケーターを表示しない
        .hidden(!store.repoAggregateRoot.hasNext)
      }
      .alert(isPresented: $store.isErrorShown) { () -> Alert in
        Alert(title: Text(store.errorTitle), message: Text(store.errorMessage))
      }
      .navigationBarTitle(Text("repo_list_view.navigation_bar_title.repositories", bundle: .current))
      .navigation(router)
    }
    .edgesIgnoringSafeArea([.top, .bottom])
  }
}

#if DEBUG
  struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
      AppPreview {
        RepoListView(store: .mock, router: RepoListRouterImpl(isPresented: .constant(false)))
      }
    }
  }
#endif
