//
//  APIClientProviderKey.swift
//  Infrastructure
//
//  Created by okudera on 2022/01/06.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

private struct APIClientProviderKey: InjectionKey {
  static var currentValue: APIClientProviding = APIClient()
}

extension InjectedValues {
  var apiClientProvider: APIClientProviding {
    get { Self[APIClientProviderKey.self] }
    set { Self[APIClientProviderKey.self] = newValue }
  }
}
