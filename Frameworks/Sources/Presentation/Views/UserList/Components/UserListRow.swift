//
//  UserListRow.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Kingfisher
import SwiftUI

struct UserListRow: View {
  @Environment(\.colorScheme) private var colorScheme
  @State var title: String
  @State var avatarUrl: URL
  let rowAction: () -> Void
  let imageAction: () -> Void

  var body: some View {
    Button(action: rowAction) {
      HStack {
        Button(action: imageAction) {
          KFImage(avatarUrl)
            .cacheOriginalImage()
            .placeholder { ProgressView() }
            .fade(duration: 0.5)
            .resizable()
            .frame(width: 44, height: 44)
            .cornerRadius(22)
            .shadow(color: colorScheme == .light ? .gray : .clear, radius: 2)
        }
        Text(title)
          .lineLimit(1)
          .foregroundColor(colorScheme == .light ? .black : .white)
      }
    }
  }
}

#if DEBUG
  struct UserListRow_Previews: PreviewProvider {
    static var previews: some View {
      ColorSchemePreview {
        UserListRow(
          title: "octocat",
          avatarUrl: resourceUrl(name: "octocat", ofType: "png"),
          rowAction: {},
          imageAction: {}
        )
        .previewLayout(.sizeThatFits)
      }
    }
  }
#endif
