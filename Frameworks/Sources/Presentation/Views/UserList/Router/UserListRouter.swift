//
//  UserListRouter.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/14.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

protocol UserListRouter: Router {
  func navigateToGeneralWebView(urlString: String)
}

final class UserListRouterImpl: Router, UserListRouter {

  func navigateToGeneralWebView(urlString: String) {
    let router = Router(isPresented: isNavigating)
    navigateTo(
      GeneralWebView(urlString: urlString, router: router)
    )
  }
}
