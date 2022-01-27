//
//  UserRepositoryProviderKey.swift
//  Application
//
//  Created by Yuki Okudera on 2022/01/16.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Domain
import Infrastructure

private struct UserRepositoryProviderKey: InjectionKey {
  static var currentValue: UserRepositoryProviding = UserRepository()
}

extension InjectedValues {
  var userRepositoryProvider: UserRepositoryProviding {
    get { Self[UserRepositoryProviderKey.self] }
    set { Self[UserRepositoryProviderKey.self] = newValue }
  }
}
