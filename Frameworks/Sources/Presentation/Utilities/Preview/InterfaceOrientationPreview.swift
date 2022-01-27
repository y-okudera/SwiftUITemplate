//
//  InterfaceOrientationPreview.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/23.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

struct InterfaceOrientationPreview<Content>: View where Content: View {
  let content: () -> Content

  var body: some View {
    content()
    content()
      .landscape()
  }
}

// MARK: - private struct
private struct LandscapeModifier: ViewModifier {
  private let height = UIScreen.main.bounds.width
  private let width = UIScreen.main.bounds.height

  private var isPad: Bool {
    return height >= 768
  }

  private var isRegularWidth: Bool {
    return height >= 414
  }

  func body(content: Content) -> some View {
    content
      .previewLayout(.fixed(width: width, height: height))
      .environment(\.horizontalSizeClass, isRegularWidth ? .regular : .compact)
      .environment(\.verticalSizeClass, isPad ? .regular : .compact)
  }
}

// MARK: - extension
extension View {
  func landscape() -> some View {
    self.modifier(LandscapeModifier())
  }
}
