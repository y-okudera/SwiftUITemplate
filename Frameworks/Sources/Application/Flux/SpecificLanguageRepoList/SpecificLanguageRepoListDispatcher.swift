//
//  SpecificLanguageRepoListDispatcher.swift
//  Application
//
//  Created by okudera on 2022/01/20.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine

public final class SpecificLanguageRepoListDispatcher {
  public static let shared = SpecificLanguageRepoListDispatcher()

  private let actionSubject = PassthroughSubject<SpecificLanguageRepoListAction, Never>()
  private var cancellables: [AnyCancellable] = []

  func register(callback: @escaping (SpecificLanguageRepoListAction) -> Void) {
    let actionStream = actionSubject.sink(receiveValue: callback)
    cancellables += [actionStream]
  }

  func dispatch(_ action: SpecificLanguageRepoListAction) {
    actionSubject.send(action)
  }
}
