//
//  LanguagesRepoRepositoryProviderKey.swift
//  Application
//
//  Created by Yuki Okudera on 2022/01/22.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Domain
import Infrastructure

private struct LanguagesRepoRepositoryProviderKey: InjectionKey {
  static var currentValue: LanguagesRepoRepositoryProviding = LanguagesRepoRepository()
}

extension InjectedValues {
  var languagesRepoRepositoryProvider: LanguagesRepoRepositoryProviding {
    get { Self[LanguagesRepoRepositoryProviderKey.self] }
    set { Self[LanguagesRepoRepositoryProviderKey.self] = newValue }
  }
}
