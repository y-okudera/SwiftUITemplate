//
//  APIError.swift
//  Domain
//
//  Created by Yuki Okudera on 2022/01/16.
//  Copyright © 2022 yuoku. All rights reserved.
//

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
}

extension APIError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .cannotConnected:
      return "通信に失敗しました。"
    case .invalidResponse:
      return "不正なレスポンスを取得しました。"
    case .clientError(let statusCode):
      return "クライアントエラー(\(statusCode))"
    case .serverError(let statusCode):
      return "サーバーエラー(\(statusCode))"
    case .decodeError:
      return "デコードエラー"
    case .unknown:
      return "その他エラー"
    }
  }

  public var recoverySuggestion: String? {
    switch self {
    case .cannotConnected:
      return "通信環境の良い場所で再度お試しください。"
    case .invalidResponse(let error):
      return (error as NSError).localizedRecoverySuggestion ?? error.reflectedString
    case .clientError:
      return nil
    case .serverError:
      return nil
    case .decodeError(let decodingError):
      return (decodingError as NSError).localizedRecoverySuggestion ?? decodingError.reflectedString
    case .unknown(let error):
      return (error as NSError).localizedRecoverySuggestion ?? error.reflectedString
    }
  }
}
