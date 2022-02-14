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
        owner: UserEntity.mock
      )
    }

    public static var mockArray: [Self] {
      [
        Self(
          id: "21700699",
          fullName: "vsouza/awesome-ios",
          description: "A curated list of awesome iOS ecosystem, including Objective-C and Swift Projects ",
          stargazersCount: 38983,
          language: "Swift",
          htmlUrl: URL(string: "https://github.com/vsouza/awesome-ios")!,
          owner: UserEntity(
            id: "484656",
            login: "vsouza",
            avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/484656?v=4")!,
            htmlUrl: URL(string: "https://github.com/vsouza")!,
            type: "User"
          )
        ),
        Self(
          id: "22458259",
          fullName: "Alamofire/Alamofire",
          description: "Elegant HTTP Networking in Swift",
          stargazersCount: 37099,
          language: "Swift",
          htmlUrl: URL(string: "https://github.com/Alamofire/Alamofire")!,
          owner: UserEntity(
            id: "7774181",
            login: "Alamofire",
            avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/7774181?v=4")!,
            htmlUrl: URL(string: "https://github.com/Alamofire")!,
            type: "Organization"
          )
        ),
        Self(
          id: "60844036",
          fullName: "shadowsocks/ShadowsocksX-NG",
          description: "Next Generation of ShadowsocksX",
          stargazersCount: 30127,
          language: "Swift",
          htmlUrl: URL(string: "https://github.com/shadowsocks/ShadowsocksX-NG")!,
          owner: UserEntity(
            id: "3006190",
            login: "shadowsocks",
            avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/3006190?v=4")!,
            htmlUrl: URL(string: "https://github.com/shadowsocks")!,
            type: "Organization"
          )
        ),
        Self(
          id: "109343098",
          fullName: "serhii-londar/open-source-mac-os-apps",
          description: "🚀 Awesome list of open source applications for macOS. https://t.me/s/opensourcemacosapps",
          stargazersCount: 29417,
          language: "Swift",
          htmlUrl: URL(string: "https://github.com/serhii-londar/open-source-mac-os-apps")!,
          owner: UserEntity(
            id: "15808174",
            login: "serhii-londar",
            avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/15808174?v=4")!,
            htmlUrl: URL(string: "https://github.com/serhii-londar")!,
            type: "User"
          )
        ),
        Self(
          id: "29887499",
          fullName: "dkhamsing/open-source-ios-apps",
          description: ":iphone: Collaborative List of Open-Source iOS Apps",
          stargazersCount: 29338,
          language: "Swift",
          htmlUrl: URL(string: "https://github.com/dkhamsing/open-source-ios-apps")!,
          owner: UserEntity(
            id: "4723115",
            login: "dkhamsing",
            avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/4723115?v=4")!,
            htmlUrl: URL(string: "https://github.com/dkhamsing")!,
            type: "User"
          )
        ),
      ]
    }
  }
#endif
