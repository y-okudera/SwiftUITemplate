//
//  LocalizePreview.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/23.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

struct LocalizePreview<Content>: View where Content: View {
  let content: () -> Content

  private let localizations: [Locale] = {
    Bundle.current.localizations
      .map(Locale.init)
      .filter { $0.identifier != "base" }
  }()

  var body: some View {
    ForEach(localizations, id: \.identifier) { locale in
      content()
        .environment(\.locale, locale)
    }
  }
}
