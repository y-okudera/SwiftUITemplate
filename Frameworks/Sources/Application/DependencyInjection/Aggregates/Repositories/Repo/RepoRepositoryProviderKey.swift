//
//  RepoRepositoryProviderKey.swift
//  Application
//
//  Created by Yuki Okudera on 2022/01/16.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Domain
import Infrastructure

private struct RepoRepositoryProviderKey: InjectionKey {
  static var currentValue: RepoRepositoryProviding = RepoRepository()
}

extension InjectedValues {
  var repoRepositoryProvider: RepoRepositoryProviding {
    get { Self[RepoRepositoryProviderKey.self] }
    set { Self[RepoRepositoryProviderKey.self] = newValue }
  }
}
