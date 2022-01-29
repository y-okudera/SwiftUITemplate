//
//  LanguagesRepoRepositoryProviding.swift
//  Domain
//
//  Created by Yuki Okudera on 2022/01/22.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine

public protocol LanguagesRepoRepositoryProviding {
  func response(searchQuery: String, page: Int) -> AnyPublisher<LanguagesRepoAggregateRoot, APIError>
}
