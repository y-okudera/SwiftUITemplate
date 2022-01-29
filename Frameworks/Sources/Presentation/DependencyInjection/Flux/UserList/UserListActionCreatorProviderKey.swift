//
//  UserListActionCreatorProviderKey.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/29.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Application

private struct UserListActionCreatorProviderKey: InjectionKey {
  static var currentValue: UserListActionCreatorProviding = UserListActionCreator()
}

extension InjectedValues {
  var userListActionCreatorProvider: UserListActionCreatorProviding {
    get { Self[UserListActionCreatorProviderKey.self] }
    set { Self[UserListActionCreatorProviderKey.self] = newValue }
  }
}
