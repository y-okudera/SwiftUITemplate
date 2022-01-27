//
//  SheetModifier.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/14.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

struct SheetModifier: ViewModifier {

  @Binding var presentingView: AnyView?

  func body(content: Content) -> some View {
    content.sheet(
      isPresented: Binding(
        get: {
          self.presentingView != nil
        },
        set: {
          if !$0 {
            self.presentingView = nil
          }
        }
      )
    ) {
      self.presentingView
    }
  }
}
