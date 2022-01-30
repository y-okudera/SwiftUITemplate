//
//  GeneralWebView.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/05.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

struct GeneralWebView: View {
  private let urlString: String?
  private let router: Router

  init(urlString: String?, router: Router) {
    self.urlString = urlString
    self.router = router
  }

  var body: some View {
    WebView(urlString: urlString ?? "")
  }
}

#if DEBUG
  struct GeneralWebView_Previews: PreviewProvider {
    static var previews: some View {
      ColorSchemePreview {
        GeneralWebView(
          urlString: "https://github.com/octocat",
          router: Router(isPresented: .constant(false))
        )
        .previewLayout(.sizeThatFits)
      }
    }
  }
#endif
