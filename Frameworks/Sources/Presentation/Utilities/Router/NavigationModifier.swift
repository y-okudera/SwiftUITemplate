//
//  NavigationModifier.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/14.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

struct NavigationModifier: ViewModifier {

  @Binding var presentingView: AnyView?

  func body(content: Content) -> some View {
    content.background(
      NavigationLink(
        destination: self.presentingView,
        isActive: Binding(
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
        EmptyView()
      }
    )
  }
}
