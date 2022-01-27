//
//  SpecificLanguageRepoListView.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/21.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Application
import PagerTabStripView
import SwiftUI

struct SpecificLanguageRepoListView<R: SpecificLanguageRepoListRouter>: View {
  @Environment(\.colorScheme) private var colorScheme
  @ObservedObject private var store: SpecificLanguageRepoListStore = .shared
  @StateObject private var router: R
  private let language: String
  private var actionCreator: SpecificLanguageRepoListActionCreator

  init(
    router: R,
    actionCreator: SpecificLanguageRepoListActionCreator = .init(),
    language: String
  ) {
    _router = StateObject(wrappedValue: router)
    self.language = language
    self.actionCreator = actionCreator
  }

  #warning(".pagerTabItemと.onPageAppearがあると、Previewが効かなくなるので修正が必要")
  var body: some View {
    List {
      ForEach(store.languagesRepoAggregateRoot.filterByLanguage(language)) { repository in
        RepoListRow(title: repository.fullName, language: repository.language ?? "") {
          router.navigateToGeneralWebView(urlString: repository.htmlUrl.absoluteString)
        }
      }
      HStack {
        Spacer()
        ProgressView()
          .onAppear {
            actionCreator.reachedBottom(
              searchQuery: store.searchQuery,
              page: store.languagesRepoAggregateRoot.page(language: language)
            )
          }
        Spacer()
      }
      // 次のページがない場合、リスト末尾にインジケーターを表示しない
      .hidden(!store.languagesRepoAggregateRoot.hasNext(language: language))
    }
    .alert(isPresented: $store.isErrorShown) { () -> Alert in
      Alert(title: Text(store.errorTitle), message: Text(store.errorMessage))
    }
    .navigation(router)
    .pagerTabItem {
      TitleNavBarItem(title: language)
    }
    .onPageAppear {
      store.searchQuery = "language:\(language)"
      if store.languagesRepoAggregateRoot.filterByLanguage(language).isEmpty {
        actionCreator.onPageAppear(searchQuery: store.searchQuery)
      }
    }
  }
}

#if DEBUG
  struct SpecificLanguageRepoListView_Previews: PreviewProvider {
    static var previews: some View {
      AppPreview {
        SpecificLanguageRepoListView(
          router: SpecificLanguageRepoListRouterImpl(isPresented: .constant(false)),
          language: "Swift"
        )
      }
    }
  }
#endif
