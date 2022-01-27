//
//  RepoListDispatcher.swift
//  Application
//
//  Created by Yuki Okudera on 2022/01/05.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine

public final class RepoListDispatcher {
  public static let shared = RepoListDispatcher()

  private let actionSubject = PassthroughSubject<RepoListAction, Never>()
  private var cancellables: [AnyCancellable] = []

  func register(callback: @escaping (RepoListAction) -> Void) {
    let actionStream = actionSubject.sink(receiveValue: callback)
    cancellables += [actionStream]
  }

  func dispatch(_ action: RepoListAction) {
    actionSubject.send(action)
  }
}
