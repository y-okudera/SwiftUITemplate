//
//  AppPreview.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/24.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

struct AppPreview<Content>: View where Content: View {
  let content: () -> Content

  private let previewDevices = [
    "iPhone SE (1st generation)",
    "iPhone 8",
    "iPhone 13 Pro Max",
  ]

  private let localizations: [Locale] = {
    Bundle.current.localizations
      .map(Locale.init)
      .filter { $0.identifier != "base" }
  }()

  var body: some View {
    ForEach(localizations, id: \.identifier) { locale in
      ForEach(previewDevices, id: \.self) { previewDevice in
        content()
          .previewDevice(PreviewDevice(rawValue: previewDevice))
          .previewDisplayName("portrait-\(previewDevice)-\(locale.identifier)")
        content()
          .previewDevice(PreviewDevice(rawValue: previewDevice))
          .previewDisplayName("landscape-\(previewDevice)-\(locale.identifier)")
          .landscape()
      }
      .environment(\.locale, locale)
    }

    // Dark Mode
    content()
      .preferredColorScheme(.dark)
      .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
      .previewDisplayName("dark-portrait-iPhone 8")
    content()
      .preferredColorScheme(.dark)
      .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
      .previewDisplayName("dark-landscape-iPhone 8")
      .landscape()
  }
}
