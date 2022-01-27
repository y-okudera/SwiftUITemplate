//
//  SearchRepositoryResponse.swift
//  Infrastructure
//
//  Created by Yuki Okudera on 2022/01/08.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

public struct SearchRepositoryResponse: Decodable {
  public let items: [GitHubRepository]
}
