//
//  SearchRepositoryRequest.swift
//  Infrastructure
//
//  Created by Yuki Okudera on 2022/01/05.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation
import Request

public struct SearchRepositoryRequest: APIRequestable {
  public typealias Response = SearchRepositoryResponse

  private let searchQuery: String
  private let page: Int

  public init(searchQuery: String, page: Int = 1) {
    self.searchQuery = searchQuery
    self.page = page
  }

  public var path: String {
    return "/search/repositories"
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
