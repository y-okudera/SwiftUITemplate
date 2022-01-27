//
//  UserAggregateRoot.swift
//  Domain
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

public struct UserAggregateRoot {
  public let page: Int
  public let hasNext: Bool
  private let userIDs: [String]
  private let usersByID: [String: UserAggregate]

  public var users: [UserAggregate] {
    userIDs.compactMap { usersByID[$0] }
  }

  public init(page: Int, hasNext: Bool, userIDs: [String], usersByID: [String: UserAggregate]) {
    self.page = page
    self.hasNext = hasNext
    self.userIDs = userIDs
    self.usersByID = usersByID
  }

  public init() {
    self.init(page: 1, hasNext: false, userIDs: [], usersByID: [:])
  }

  public mutating func set(newValue: UserAggregateRoot) {
    let userIDs = userIDs + newValue.userIDs
    let usersByID = usersByID.merging(newValue.usersByID) { $1 }
    self = .init(page: newValue.page, hasNext: newValue.hasNext, userIDs: userIDs, usersByID: usersByID)
  }
}

// MARK: - Mock
#if DEBUG
  extension UserAggregateRoot {
    public static func mock(mockAvatarUrl: URL) -> Self {
      let userAggregateMockArray = UserAggregate.mockArray(mockAvatarUrl: mockAvatarUrl)
      return Self(
        page: 1,
        hasNext: true,
        userIDs: userAggregateMockArray.map { $0.id },
        usersByID: userAggregateMockArray.reduce(into: [String: UserAggregate]()) { $0[$1.id] = $1 }
      )
    }
  }
#endif
