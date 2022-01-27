//
//  InjectedValues.swift
//  Infrastructure
//
//  Created by okudera on 2022/01/06.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

/// Provides access to injected dependencies.
public struct InjectedValues {

  /// This is only used as an accessor to the computed properties within extensions of `InjectedValues`.
  private static var current = InjectedValues()

  /// A static subscript for updating the `currentValue` of `InjectionKey` instances.
  public static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey {
    get { key.currentValue }
    set { key.currentValue = newValue }
  }

  /// A static subscript accessor for updating and references dependencies directly.
  public static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
    get { current[keyPath: keyPath] }
    set { current[keyPath: keyPath] = newValue }
  }
}
