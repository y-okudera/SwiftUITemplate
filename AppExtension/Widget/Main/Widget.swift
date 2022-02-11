//
//  Widget.swift
//  Widget
//
//  Created by Yuki Okudera on 2022/02/11.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI
import WidgetKit

@main
struct Widget: SwiftUI.Widget {
  private let kind: String = "jp.yuoku.GitHubApp.Widget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: StaticProvider()) { timelineEntry in
      WidgetEntryView(entry: timelineEntry)
    }
    .configurationDisplayName("GitHubApp Widget")
    .description("Randomly picked up repository.")
  }
}
