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
    #warning("遷移処理未定義")
    //    let router = Router(isPresented: isNavigating)
    //    navigateTo(
    //      GeneralWebView(urlString: urlString, router: router)
    //    )
  }
}
