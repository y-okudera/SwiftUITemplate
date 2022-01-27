//
//  LanguagesPaginationAggregate.swift
//  Domain
//
//  Created by Yuki Okudera on 2022/01/23.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

/// searchQuery毎にPaginationを管理する
public struct LanguagesPaginationAggregate: Identifiable, Hashable {
  public let id: String
  public let page: Int
  public let hasNext: Bool

  public init(
    id: String,
    page: Int,
    hasNext: Bool
  ) {
    self.id = id
    self.page = page
    self.hasNext = hasNext
  }
}

// MARK: - Mock
#if DEBUG
  extension LanguagesPaginationAggregate {
    public static var mock: Self {
      return Self(
        id: "Swift",
        page: 1,
        hasNext: true
      )
    }
  }
#endif
