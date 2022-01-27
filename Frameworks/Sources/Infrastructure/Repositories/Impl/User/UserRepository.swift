//
//  UserRepository.swift
//  Infrastructure
//
//  Created by Yuki Okudera on 2022/01/17.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine
import Domain

public struct UserRepository: UserRepositoryProviding {

  public init() {}

  @Injected(\.apiClientProvider)
  private var apiClient: APIClientProviding

  public func response(searchQuery: String, page: Int) -> AnyPublisher<UserAggregateRoot, Domain.APIError> {
    apiClient.response(from: SearchUserRequest(searchQuery: searchQuery, page: page))
      .map { apiResponse in
        let userIDs = apiResponse.response.items.map { $0.id.description }
        let usersByID = apiResponse.response.items.reduce(into: [String: UserAggregate]()) {
          $0[$1.id.description] = UserAggregate(id: $1.id.description, login: $1.login, avatarUrl: $1.avatarUrl, htmlUrl: $1.htmlUrl)
        }
        return UserAggregateRoot(
          page: page + 1,
          hasNext: apiResponse.gitHubAPIPagination?.hasNext ?? false,
          userIDs: userIDs,
          usersByID: usersByID
        )
      }
      .mapError { APIError(error: $0).convertToDomainError() }
      .eraseToAnyPublisher()
  }
}
