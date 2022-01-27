//
//  GitHubUser.swift
//  Infrastructure
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

public struct GitHubUser: Decodable {
  public let id: Int64
  public let login: String
  public let avatarUrl: URL
  public let htmlUrl: URL
}
