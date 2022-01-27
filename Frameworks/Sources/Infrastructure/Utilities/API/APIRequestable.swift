//
//  APIRequestable.swift
//  Infrastructure
//
//  Created by Yuki Okudera on 2022/01/06.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation
import Request

public protocol APIRequestable {
  associatedtype Response: Decodable

  var baseUrl: String { get }
  var path: String { get }
  var method: MethodType { get }

  var queryItems: [URLQueryItem]? { get }
  var bodyItems: [String: Any]? { get }
}

extension APIRequestable {
  public var baseUrl: String {
    return "https://api.github.com"
  }

  public var queryItems: [URLQueryItem]? {
    return nil
  }

  public var bodyItems: [String: Any]? {
    return nil
  }
}
