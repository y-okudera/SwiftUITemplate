//
//  APIClient.swift
//  Infrastructure
//
//  Created by Yuki Okudera on 2022/01/05.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine
import Foundation
import Json
import Request

public protocol APIClientProviding {
  func response<T: APIRequestable>(from apiRequest: T) -> AnyPublisher<APIResponse<T.Response>, Error>
}

public struct APIClient: APIClientProviding {

  public init() {}

  public func response<T: APIRequestable>(from apiRequest: T) -> AnyPublisher<APIResponse<T.Response>, Error> {
    Request {
      Url(apiRequest.baseUrl + apiRequest.path)
      Header.Accept(.json)
      Timeout(30, for: .request)
      Timeout(30, for: .resource)

      if let queryItems = apiRequest.queryItems {
        Query(queryItems.compactMap { $0.value == nil ? nil : .init($0.name, value: $0.value!) })
      }
      if let bodyItems = apiRequest.bodyItems {
        Body(bodyItems)
      }
    }
    .tryMap { element -> (APIResponse<T.Response>) in
      guard let httpResponse = element.response as? HTTPURLResponse else {
        throw APIError.invalidResponse(URLError(.badServerResponse))
      }

      switch httpResponse.statusCode {
      case 200...299:
        do {
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase
          let responseObject = try decoder.decode(T.Response.self, from: element.data)
          return APIResponse(response: responseObject, httpURLResponse: httpResponse)
        } catch let decodingError as DecodingError {
          throw APIError.decodeError(decodingError)
        }
      case 400...499:
        throw APIError.clientError(httpResponse.statusCode)
      case 500...599:
        throw APIError.serverError(httpResponse.statusCode)
      default:
        throw APIError.invalidResponse(URLError(.badServerResponse))
      }
    }
    .mapError { APIError(error: $0) }
    .receive(on: RunLoop.main)
    .eraseToAnyPublisher()
  }
}
