//
//  RepoListRouter.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/14.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

public protocol RepoListRouter: Router {
  func navigateToGeneralWebView(urlString: String)
}

public final class RepoListRouterImpl: Router, RepoListRouter {

  public func navigateToGeneralWebView(urlString: String) {
    let router = Router(isPresented: isNavigating)
    navigateTo(
      GeneralWebView(urlString: urlString, router: router)
    )
  }
}
