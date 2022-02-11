//
//  WidgetEntryView.swift
//  Widget
//
//  Created by Yuki Okudera on 2022/02/11.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Kingfisher
import SwiftUI
import WidgetKit

struct WidgetEntryView: View {
  @Environment(\.colorScheme) private var colorScheme
  var entry: StaticProvider.Entry

  var body: some View {
    VStack {
      Text("Random Repo")
        .foregroundColor(colorScheme == .light ? .black : .white)
        .font(.headline)
      KFImage(entry.repoEntity.owner.avatarUrl)
        .cacheOriginalImage()
        .placeholder { ProgressView() }
        .fade(duration: 0.5)
        .resizable()
        .frame(width: 66, height: 66)
        .cornerRadius(33)
        .shadow(color: colorScheme == .light ? .gray : .clear, radius: 2)
      Text(entry.repoEntity.fullName)
        .foregroundColor(colorScheme == .light ? .black : .white)
        .font(.body)
        .lineLimit(2)
    }
    .widgetURL(URL(string: "gitHubApp://repo?url=\(entry.repoEntity.htmlUrl.absoluteString)")!)
  }
}

struct Widget_Previews: PreviewProvider {
  static var previews: some View {
    WidgetEntryView(entry: .init(date: Date(), repoEntity: .mock))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
