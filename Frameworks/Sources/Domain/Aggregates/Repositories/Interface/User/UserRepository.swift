//
//  UserRepository.swift
//  Domain
//
//  Created by Yuki Okudera on 2022/01/16.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine

public protocol UserRepositoryProviding {
  func response(searchQuery: String, page: Int) -> AnyPublisher<UserAggregateRoot, APIError>
}
