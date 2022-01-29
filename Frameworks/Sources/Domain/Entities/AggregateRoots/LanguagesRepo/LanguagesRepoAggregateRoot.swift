//
//  LanguagesRepoAggregateRoot.swift
//  Domain
//
//  Created by Yuki Okudera on 2022/01/22.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

public struct LanguagesRepoAggregateRoot {
  private let repositoryIDs: [String]
  private let repositoriesByID: [String: RepoEntity]
  private let ownersByID: [String: UserEntity]
  private let paginationByLanguage: [String: LanguagesPaginationEntity]

  public init(
    repositoryIDs: [String],
    repositoriesByID: [String: RepoEntity],
    ownersByID: [String: UserEntity],
    paginationByLanguage: [String: LanguagesPaginationEntity]
  ) {
    self.repositoryIDs = repositoryIDs
    self.repositoriesByID = repositoriesByID
    self.ownersByID = ownersByID
    self.paginationByLanguage = paginationByLanguage
  }

  public init() {
    self.init(repositoryIDs: [], repositoriesByID: [:], ownersByID: [:], paginationByLanguage: [:])
  }

  public mutating func set(newValue: LanguagesRepoAggregateRoot) {
    let repositoryIDs = repositoryIDs + newValue.repositoryIDs
    let repositoriesByID = repositoriesByID.merging(newValue.repositoriesByID) { $1 }
    let ownersByID = ownersByID.merging(newValue.ownersByID) { $1 }
    let paginationByLanguage = paginationByLanguage.merging(newValue.paginationByLanguage) { $1 }

    self = .init(
      repositoryIDs: repositoryIDs,
      repositoriesByID: repositoriesByID,
      ownersByID: ownersByID,
      paginationByLanguage: paginationByLanguage
    )
  }
}

// MARK: - public
extension LanguagesRepoAggregateRoot {

  public var repositories: [RepoEntity] {
    repositoryIDs.compactMap { repositoriesByID[$0] }
  }

  public func filterByLanguage(_ language: String) -> [RepoEntity] {
    repositoryIDs
      .compactMap { repositoriesByID[$0] }
      .filter { $0.language == language }
  }

  public func page(language: String) -> Int {
    paginationByLanguage[language]?.page ?? 1
  }

  public func hasNext(language: String) -> Bool {
    paginationByLanguage[language]?.hasNext ?? false
  }
}
