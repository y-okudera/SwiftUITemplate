//
//  TitleNavBarItem.swift
//  Presentation
//
//  Created by okudera on 2022/01/20.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

struct TitleNavBarItem: View {
  @Environment(\.colorScheme) private var colorScheme
  @State var title: String

  var body: some View {
    VStack {
      Text(title)
        .foregroundColor(colorScheme == .light ? .black : .white)
        .font(.subheadline)
    }
    .frame(minWidth: 35.0, maxHeight: .infinity)
  }
}

#if DEBUG
  struct TitleNavBarItem_Previews: PreviewProvider {
    static var previews: some View {
      ColorSchemePreview {
        TitleNavBarItem(title: "Swift")
          .previewLayout(.sizeThatFits)
      }
    }
  }
#endif
