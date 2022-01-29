//
//  RepoAggregateRoot.swift
//  Domain
//
//  Created by Yuki Okudera on 2022/01/08.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

public struct RepoAggregateRoot {
  public let page: Int
  public let hasNext: Bool
  private let repositoryIDs: [String]
  private let repositoriesByID: [String: RepoEntity]
  private let ownersByID: [String: UserEntity]

  public var repositories: [RepoEntity] {
    repositoryIDs.compactMap { repositoriesByID[$0] }
  }

  public init(
    page: Int,
    hasNext: Bool,
    repositoryIDs: [String],
    repositoriesByID: [String: RepoEntity],
    ownersByID: [String: UserEntity]
  ) {
    self.page = page
    self.hasNext = hasNext
    self.repositoryIDs = repositoryIDs
    self.repositoriesByID = repositoriesByID
    self.ownersByID = ownersByID
  }

  public init() {
    self.init(page: 1, hasNext: false, repositoryIDs: [], repositoriesByID: [:], ownersByID: [:])
  }

  public mutating func set(newValue: RepoAggregateRoot) {
    let repositoryIDs = repositoryIDs + newValue.repositoryIDs
    let repositoriesByID = repositoriesByID.merging(newValue.repositoriesByID) { $1 }
    let ownersByID = ownersByID.merging(newValue.ownersByID) { $1 }

    self = .init(
      page: newValue.page,
      hasNext: newValue.hasNext,
      repositoryIDs: repositoryIDs,
      repositoriesByID: repositoriesByID,
      ownersByID: ownersByID
    )
  }
}

// MARK: - Mock
#if DEBUG
  extension RepoAggregateRoot {
    public static var mock: Self {
      let repoEntityMockArray = RepoEntity.mockArray
      return Self(
        page: 1,
        hasNext: true,
        repositoryIDs: repoEntityMockArray.map { $0.id },
        repositoriesByID: repoEntityMockArray.reduce(into: [String: RepoEntity]()) { $0[$1.id] = $1 },
        ownersByID: repoEntityMockArray.reduce(into: [String: UserEntity]()) { $0[$1.owner.id] = $1.owner }
      )
    }
  }
#endif
