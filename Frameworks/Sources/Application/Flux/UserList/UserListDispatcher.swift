//
//  UserListDispatcher.swift
//  Application
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine

public final class UserListDispatcher {
  public static let shared = UserListDispatcher()

  private let actionSubject = PassthroughSubject<UserListAction, Never>()
  private var cancellables: [AnyCancellable] = []

  func register(callback: @escaping (UserListAction) -> Void) {
    let actionStream = actionSubject.sink(receiveValue: callback)
    cancellables += [actionStream]
  }

  func dispatch(_ action: UserListAction) {
    actionSubject.send(action)
  }
}
