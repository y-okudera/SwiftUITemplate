//
//  RepoListView.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/01.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Application
import SwiftUI

public struct RepoListView: View {
  @ObservedObject private var store: RepoListStore

  @Injected(\.repoListActionCreatorProvider)
  private var actionCreator: RepoListActionCreatorProviding

  public init(store: RepoListStore = .shared) {
    self.store = store
  }

  public var body: some View {
    Text("RepoListView")
  }
}

#if DEBUG
  struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
      RepoListView(store: .mock)
    }
  }
#endif
