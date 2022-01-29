//
//  RepoListActionCreatorProviderKey.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/29.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Application

private struct RepoListActionCreatorProviderKey: InjectionKey {
  static var currentValue: RepoListActionCreatorProviding = RepoListActionCreator()
}

extension InjectedValues {
  var repoListActionCreatorProvider: RepoListActionCreatorProviding {
    get { Self[RepoListActionCreatorProviderKey.self] }
    set { Self[RepoListActionCreatorProviderKey.self] = newValue }
  }
}
