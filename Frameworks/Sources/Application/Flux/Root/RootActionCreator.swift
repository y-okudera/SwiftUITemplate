//
//  RootActionCreator.swift
//  Application
//
//  Created by yuoku on 30/01/2022.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine

public protocol RootActionCreatorProviding {
  func openURL(_ url: URL)
}

public final class RootActionCreator: RootActionCreatorProviding {

  private let dispatcher: RootDispatcher
  private let openURLSubject = PassthroughSubject<URL, Never>()
  private let deepLinkSubject = PassthroughSubject<DeepLink?, Never>()

  private var cancellables: [AnyCancellable] = []

  public init(dispatcher: RootDispatcher = .shared) {
    self.dispatcher = dispatcher
    bindData()
    bindActions()
  }

  // MARK: - Input

  public func openURL(_ url: URL) {
    openURLSubject.send(url)
  }

  // MARK: - Binding

  private func bindData() {

    let deepLinkStream =
      openURLSubject
      .map { DeepLink(url: $0) }
      .subscribe(deepLinkSubject)

    cancellables += [
      deepLinkStream
    ]
  }

  private func bindActions() {
    let deepLinkStream =
      deepLinkSubject
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.openURL($0)) })

    cancellables += [
      deepLinkStream
    ]
  }
}
