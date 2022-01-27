//
//  SearchUserRequest.swift
//  Infrastructure
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation
import Request

public struct SearchUserRequest: APIRequestable {
  public typealias Response = SearchUserResponse

  private let searchQuery: String
  private let page: Int

  public init(searchQuery: String, page: Int = 1) {
    self.searchQuery = searchQuery
    self.page = page
  }

  public var path: String {
    return "/search/users"
  }

  public var method: MethodType {
    return .get
  }

  public var queryItems: [URLQueryItem]? {
    return [
      .init(name: "q", value: searchQuery),
      .init(name: "order", value: "desc"),
      .init(name: "per_page", value: "20"),
      .init(name: "page", value: page.description),
    ]
  }
}
