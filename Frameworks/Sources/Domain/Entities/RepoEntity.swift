//
//  RepoEntity.swift
//  Domain
//
//  Created by Yuki Okudera on 2022/01/08.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

public struct RepoEntity: Decodable, Hashable, Identifiable {
  public let id: String
  public let fullName: String
  public let description: String?
  public let stargazersCount: Int
  public let language: String?
  public let htmlUrl: URL
  public let owner: UserEntity

  public init(
    id: String,
    fullName: String,
    description: String?,
    stargazersCount: Int,
    language: String?,
    htmlUrl: URL,
    owner: UserEntity
  ) {
    self.id = id
    self.fullName = fullName
    self.description = description
    self.stargazersCount = stargazersCount
    self.language = language
    self.htmlUrl = htmlUrl
    self.owner = owner
  }
}

// MARK: - Mock
#if DEBUG
  extension RepoEntity {
    public static var mock: Self {
      return Self(
        id: 1_300_192.description,
        fullName: "octocat/Spoon-Knife",
        description: "This repo is for demonstration purposes only.",
        stargazersCount: 10673,
        language: "HTML",
        htmlUrl: URL(string: "https://github.com/octocat/Spoon-Knife")!,
        owner: UserEntity(
          id: 583231.description,
          login: "octocat",
          avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/583231?v=4")!,
          htmlUrl: URL(string: "https://github.com/octocat")!
        )
      )
    }

    public static var mockArray: [Self] {
      [Int](0..<20).map {
        Self(
          id: $0.description,
          fullName: "octocat/Spoon-Knife",
          description: "This repo is for demonstration purposes only.",
          stargazersCount: $0,
          language: "HTML",
          htmlUrl: URL(string: "https://github.com/octocat/Spoon-Knife")!,
          owner: UserEntity(
            id: $0.description,
            login: "octocat",
            avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/583231?v=4")!,
            htmlUrl: URL(string: "https://github.com/octocat")!
          )
        )
      }
    }
  }
#endif
