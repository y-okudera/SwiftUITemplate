//
//  APIError.swift
//  Infrastructure
//
//  Created by Yuki Okudera on 2022/01/05.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Domain
import Foundation

public enum APIError: Error {
  /// 通信エラー
  case cannotConnected
  /// 不正なレスポンス
  case invalidResponse(Error)
  /// ステータスコード400番台
  case clientError(Int)
  /// ステータスコード500番台
  case serverError(Int)
  /// レスポンスデータのdecodeに失敗
  case decodeError(DecodingError)
  /// その他のエラー
  case unknown(Error)

  public init(error: Error) {
    if let apiError = error as? APIError {
      self = apiError
      return
    }

    if let urlError = error as? URLError {
      switch urlError.code {
      case .timedOut,
        .cannotFindHost,
        .cannotConnectToHost,
        .networkConnectionLost,
        .dnsLookupFailed,
        .httpTooManyRedirects,
        .resourceUnavailable,
        .notConnectedToInternet,
        .secureConnectionFailed,
        .cannotLoadFromNetwork:
        self = APIError.cannotConnected
      default:
        self = APIError.unknown(error)
      }
      return
    }

    // errorがAPIErrorでもURLErrorでもない場合
    self = APIError.unknown(error)
  }

  func convertToDomainError() -> Domain.APIError {
    switch self {
    case .cannotConnected:
      return .cannotConnected
    case .invalidResponse(let e):
      return .invalidResponse(e)
    case .clientError(let statusCode):
      return .clientError(statusCode)
    case .serverError(let statusCode):
      return .serverError(statusCode)
    case .decodeError(let e):
      return .decodeError(e)
    case .unknown(let e):
      return .unknown(e)
    }
  }
}
