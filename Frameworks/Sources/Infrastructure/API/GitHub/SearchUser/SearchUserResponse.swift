//
//  SearchUserResponse.swift
//  Infrastructure
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

public struct SearchUserResponse: Decodable {
  public let incompleteResults: Bool
  public let items: [GitHubUser]
}
