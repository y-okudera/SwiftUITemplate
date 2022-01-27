//
//  Injected.swift
//  Infrastructure
//
//  Created by okudera on 2022/01/06.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Injected<T> {
  private let keyPath: WritableKeyPath<InjectedValues, T>
  public var wrappedValue: T {
    get { InjectedValues[keyPath] }
    set { InjectedValues[keyPath] = newValue }
  }

  public init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
    self.keyPath = keyPath
  }
}
