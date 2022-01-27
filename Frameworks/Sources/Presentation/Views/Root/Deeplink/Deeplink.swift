//
//  Deeplink.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

/// Definition of deep links
///
/// - Note: <BR>
/// e.g. `gitHubApp://tab?index=1`
///
/// e.g. `gitHubApp://repo?url=https://github.com/octocat/Spoon-Knife`
///
/// e.g. `gitHubApp://user?url=https://github.com/octocat`
enum Deeplink {
  case tab(index: Int)
  case repo(urlString: String)
  case user(urlString: String)

  init?(url: URL) {
    guard url.scheme == "gitHubApp",
      let host = url.host,
      let queryUrlComponents = URLComponents(string: url.absoluteString)
    else {
      return nil
    }

    switch host {
    case "tab":
      if let indexString = queryUrlComponents.queryItems?.first(where: { $0.name == "index" })?.value,
        let index = Int(indexString)
      {
        self = .tab(index: index)
        return
      }
    case "repo":
      if let urlString = queryUrlComponents.queryItems?.first(where: { $0.name == "url" })?.value {
        self = .repo(urlString: urlString)
        return
      }
    case "user":
      if let urlString = queryUrlComponents.queryItems?.first(where: { $0.name == "url" })?.value {
        self = .user(urlString: urlString)
        return
      }
    default:
      return nil
    }
    return nil
  }
}
