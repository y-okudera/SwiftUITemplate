//
//  RootActionCreatorProviderKey.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/30.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Application

private struct RootActionCreatorProviderKey: InjectionKey {
  static var currentValue: RootActionCreatorProviding = RootActionCreator()
}

extension InjectedValues {
  var rootActionCreatorProvider: RootActionCreatorProviding {
    get { Self[RootActionCreatorProviderKey.self] }
    set { Self[RootActionCreatorProviderKey.self] = newValue }
  }
}
