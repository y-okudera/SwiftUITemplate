//
//  RepoListRow.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/05.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

struct RepoListRow: View {
  @Environment(\.colorScheme) private var colorScheme
  @State var title: String
  @State var language: String
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      VStack {
        HStack {
          Text(title)
            .lineLimit(1)
          Spacer()
        }
        HStack {
          Text(language)
            .lineLimit(1)
            .font(.caption)
          Spacer()
        }
      }
      .foregroundColor(colorScheme == .light ? .black : .white)
    }
  }
}

#if DEBUG
  struct RepoListRow_Previews: PreviewProvider {
    static var previews: some View {
      ColorSchemePreview {
        RepoListRow(title: "octocat/Spoon-Knife", language: "HTML", action: {})
          .previewLayout(.sizeThatFits)
      }
    }
  }
#endif
