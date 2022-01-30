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
  private let usersByID: [String: UserEntity]

  public init(page: Int, hasNext: Bool, userIDs: [String], usersByID: [String: UserEntity]) {
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

// MARK: - public
extension UserAggregateRoot {

  public var users: [UserEntity] {
    userIDs.compactMap { usersByID[$0] }
  }

  public func filterByID(_ id: String) -> UserEntity? {
    userIDs
      .compactMap { usersByID[$0] }
      .filter { $0.id == id }
      .first
  }
}

// MARK: - Mock
#if DEBUG
  extension UserAggregateRoot {
    public static func mock(mockAvatarUrl: URL) -> Self {
      let userEntityMockArray = UserEntity.mockArray(mockAvatarUrl: mockAvatarUrl)
      return Self(
        page: 1,
        hasNext: true,
        userIDs: userEntityMockArray.map { $0.id },
        usersByID: userEntityMockArray.reduce(into: [String: UserEntity]()) { $0[$1.id] = $1 }
      )
    }
  }
#endif
