//
//  View+.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/09.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

// MARK: - hidden

extension View {
  func hidden(_ isHidden: Bool) -> some View {
    ModifiedContent(content: self, modifier: Hidden(hidden: isHidden))
  }
}

private struct Hidden: ViewModifier {
  let hidden: Bool

  func body(content: Content) -> some View {
    if !hidden {
      content
    }
  }
}
