//
//  ColorSchemePreview.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/23.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

struct ColorSchemePreview<Content>: View where Content: View {
  let content: () -> Content

  var body: some View {
    ForEach(ColorScheme.allCases, id: \.self) {
      content()
        .preferredColorScheme($0)
    }
  }
}
