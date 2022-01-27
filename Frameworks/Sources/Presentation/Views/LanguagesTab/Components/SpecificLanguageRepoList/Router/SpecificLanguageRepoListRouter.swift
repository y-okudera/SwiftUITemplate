//
//  SpecificLanguageRepoListRouter.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/21.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

protocol SpecificLanguageRepoListRouter: Router {
  func navigateToGeneralWebView(urlString: String)
}

final class SpecificLanguageRepoListRouterImpl: Router, SpecificLanguageRepoListRouter {

  func navigateToGeneralWebView(urlString: String) {
    let router = Router(isPresented: isNavigating)
    navigateTo(
      GeneralWebView(urlString: urlString, router: router)
    )
  }
}
