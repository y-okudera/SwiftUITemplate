//
//  UserAggregate.swift
//  Domain
//
//  Created by Yuki Okudera on 2022/01/08.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

public struct UserAggregate: Decodable, Hashable, Identifiable {
  public let id: String
  public let login: String
  public let avatarUrl: URL
  public let htmlUrl: URL

  public init(
    id: String,
    login: String,
    avatarUrl: URL,
    htmlUrl: URL
  ) {
    self.id = id
    self.login = login
    self.avatarUrl = avatarUrl
    self.htmlUrl = htmlUrl
  }
}

// MARK: - Mock
#if DEBUG
  extension UserAggregate {
    public static var mock: Self {
      return Self(
        id: 583231.description,
        login: "octocat",
        avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/583231?v=4")!,
        htmlUrl: URL(string: "https://github.com/octocat")!
      )
    }

    public static func mockArray(mockAvatarUrl: URL) -> [Self] {
      [Int](0..<20).map {
        Self(
          id: $0.description,
          login: "octocat",
          avatarUrl: mockAvatarUrl,
          htmlUrl: URL(string: "https://github.com/octocat")!
        )
      }
    }
  }
#endif
