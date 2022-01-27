//
//  LanguagesTabView.swift
//  Presentation
//
//  Created by okudera on 2022/01/20.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Application
import PagerTabStripView
import SwiftUI

struct LanguagesTabView: View {
  @Environment(\.colorScheme) private var colorScheme
  @ObservedObject private var store: LanguagesTabStore = .shared

  var body: some View {
    NavigationView {
      PagerTabStripView {
        ForEach(store.languages.indices) { index in
          SpecificLanguageRepoListView(
            router: SpecificLanguageRepoListRouterImpl(isPresented: .constant(false)),
            language: store.languages[index]
          )
        }
      }
      .pagerTabStripViewStyle(
        .scrollableBarButton(
          indicatorBarColor: .blue,
          padding: EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16),
          tabItemSpacing: 8.0,
          tabItemHeight: 44.0
        )
      )
      .navigationBarHidden(true)
    }
  }
}

#if DEBUG
  struct LanguagesTabView_Previews: PreviewProvider {
    static var previews: some View {
      ColorSchemePreview {
        LanguagesTabView()
          .previewLayout(.sizeThatFits)
      }
    }
  }
#endif
