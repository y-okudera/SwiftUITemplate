//
//  LanguagesRepoRepository.swift
//  Infrastructure
//
//  Created by Yuki Okudera on 2022/01/22.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine
import Domain

public struct LanguagesRepoRepository: LanguagesRepoRepositoryProviding {

  public init() {}

  @Injected(\.apiClientProvider)
  private var apiClient: APIClientProviding

  public func response(searchQuery: String, page: Int) -> AnyPublisher<LanguagesRepoAggregateRoot, Domain.APIError> {
    apiClient.response(from: SearchRepositoryRequest(searchQuery: searchQuery, page: page))
      .map { apiResponse in
        let repositoryIDs = apiResponse.response.items.map { $0.id.description }
        let repositoriesByID = apiResponse.response.items.reduce(into: [String: RepoEntity]()) {
          $0[$1.id.description] = RepoEntity(
            id: $1.id.description,
            fullName: $1.fullName,
            description: $1.description,
            stargazersCount: $1.stargazersCount,
            language: $1.language,
            htmlUrl: $1.htmlUrl,
            owner: UserEntity(
              id: $1.owner.id.description,
              login: $1.owner.login,
              avatarUrl: $1.owner.avatarUrl,
              htmlUrl: $1.owner.htmlUrl,
              type: $1.owner.type
            )
          )
        }
        let ownersByID = apiResponse.response.items.reduce(into: [String: UserEntity]()) {
          $0[$1.owner.id.description] = UserEntity(
            id: $1.owner.id.description,
            login: $1.owner.login,
            avatarUrl: $1.owner.avatarUrl,
            htmlUrl: $1.owner.htmlUrl,
            type: $1.owner.type
          )
        }

        let language = searchQuery.replacingOccurrences(of: "language:", with: "")
        return LanguagesRepoAggregateRoot(
          repositoryIDs: repositoryIDs,
          repositoriesByID: repositoriesByID,
          ownersByID: ownersByID,
          paginationByLanguage: [language: .init(id: language, page: page + 1, hasNext: apiResponse.gitHubAPIPagination?.hasNext ?? false)]
        )
      }
      .mapError { APIError(error: $0).convertToDomainError() }
      .eraseToAnyPublisher()
  }
}
