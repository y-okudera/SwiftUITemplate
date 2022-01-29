//
//  SpecificLanguageRepoListActionCreatorProviderKey.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/29.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Application

private struct SpecificLanguageRepoListActionCreatorProviderKey: InjectionKey {
  static var currentValue: SpecificLanguageRepoListActionCreatorProviding = SpecificLanguageRepoListActionCreator()
}

extension InjectedValues {
  var specificLanguageRepoListActionCreatorProvider: SpecificLanguageRepoListActionCreatorProviding {
    get { Self[SpecificLanguageRepoListActionCreatorProviderKey.self] }
    set { Self[SpecificLanguageRepoListActionCreatorProviderKey.self] = newValue }
  }
}
