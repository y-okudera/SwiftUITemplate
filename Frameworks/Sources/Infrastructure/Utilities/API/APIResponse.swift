//
//  APIResponse.swift
//  Infrastructure
//
//  Created by Yuki Okudera on 2022/01/08.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

public struct APIResponse<T: Decodable> {
  public var response: T
  public var statusCode: Int
  public var responseHeaderFields: [AnyHashable: Any]

  /// GitHub API specific property
  public var gitHubAPIPagination: GitHubAPIPagination?

  init(response: T, httpURLResponse: HTTPURLResponse) {
    self.response = response
    self.statusCode = httpURLResponse.statusCode
    self.responseHeaderFields = httpURLResponse.allHeaderFields
    self.gitHubAPIPagination = .init(httpURLResponse: httpURLResponse)
    print("Requested URL \(httpURLResponse.url?.absoluteString ?? "nil")")
  }
}

// MARK: GitHub API Pagination
public struct GitHubAPIPagination {
  public let hasNext: Bool

  init(hasNext: Bool) {
    self.hasNext = hasNext
  }

  init(httpURLResponse: HTTPURLResponse) {
    guard let linkField = httpURLResponse.allHeaderFields["Link"] as? String else {
      self = .init(hasNext: false)
      return
    }

    let dictionary =
      linkField
      .components(separatedBy: ",")
      .reduce(into: [String: String]()) {
        let components = $1.components(separatedBy: "; ")
        let cleanPath = components[safe: 0]?.trimmingCharacters(in: CharacterSet(charactersIn: " <>"))
        if let key = components[safe: 1] {
          $0[key] = cleanPath
        }
      }

    let nextUrl: URL? = {
      guard let next = dictionary["rel=\"next\""] else {
        return nil
      }
      return URL(string: next)
    }()

    #if DEBUG
      let firstUrl: URL? = {
        guard let first = dictionary["rel=\"first\""] else {
          return nil
        }
        return URL(string: first)
      }()
      let lastUrl: URL? = {
        guard let last = dictionary["rel=\"last\""] else {
          return nil
        }
        return URL(string: last)
      }()
      print("nextUrl", nextUrl?.absoluteString ?? "nil")
      print("firstUrl", firstUrl?.absoluteString ?? "nil")
      print("lastUrl", lastUrl?.absoluteString ?? "nil")
    #endif

    self = .init(hasNext: nextUrl != nil)
  }
}
