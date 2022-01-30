//
//  RootDispatcher.swift
//  Application
//
//  Created by yuoku on 30/01/2022.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine

public final class RootDispatcher {
  public static let shared = RootDispatcher()

  private let actionSubject = PassthroughSubject<RootAction, Never>()
  private var cancellables: [AnyCancellable] = []

  func register(callback: @escaping (RootAction) -> Void) {
    let actionStream = actionSubject.sink(receiveValue: callback)
    cancellables += [actionStream]
  }

  func dispatch(_ action: RootAction) {
    actionSubject.send(action)
  }
}
