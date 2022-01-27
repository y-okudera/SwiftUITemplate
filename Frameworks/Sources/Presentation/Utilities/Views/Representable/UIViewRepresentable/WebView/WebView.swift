//
//  WebView.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/06.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

  var urlString: String

  class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
    var parent: WebView

    init(_ parent: WebView) {
      self.parent = parent
    }

    func webView(
      _ webView: WKWebView,
      createWebViewWith configuration: WKWebViewConfiguration,
      for navigationAction: WKNavigationAction,
      windowFeatures: WKWindowFeatures
    ) -> WKWebView? {
      if navigationAction.targetFrame == nil {
        webView.load(navigationAction.request)
      }
      return nil
    }

    func webView(
      _ webView: WKWebView,
      decidePolicyFor navigationAction: WKNavigationAction,
      decisionHandler: (WKNavigationActionPolicy) -> Void
    ) {
      guard let url = navigationAction.request.url else {
        decisionHandler(WKNavigationActionPolicy.cancel)
        return
      }
      if url.absoluteString.hasPrefix("https://itunes.apple.com/jp/app/apple-store/") && UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url)
        decisionHandler(WKNavigationActionPolicy.cancel)
      } else if url.absoluteString.hasPrefix("http://") || url.absoluteString.hasPrefix("https://") {
        decisionHandler(WKNavigationActionPolicy.allow)
      } else {
        decisionHandler(WKNavigationActionPolicy.cancel)
      }
    }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()

    return webView
  }

  func updateUIView(_ webView: WKWebView, context: Context) {
    webView.uiDelegate = context.coordinator
    webView.navigationDelegate = context.coordinator
    webView.allowsBackForwardNavigationGestures = true

    let url = URL(string: urlString)!
    let request = URLRequest(url: url)
    webView.load(request)
  }
}

#if DEBUG
  struct WebView_Previews: PreviewProvider {
    static var previews: some View {
      ColorSchemePreview {
        WebView(urlString: "https://github.com/octocat")
          .previewLayout(.sizeThatFits)
      }
    }
  }
#endif
