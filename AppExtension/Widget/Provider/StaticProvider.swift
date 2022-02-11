//
//  StaticProvider.swift
//  Widget
//
//  Created by Yuki Okudera on 2022/02/11.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Domain
import WidgetKit

struct StaticProvider: TimelineProvider {
  typealias Entry = WidgetEntry

  func placeholder(in context: Self.Context) -> Self.Entry {
    print("DEBUG:", #function)
    return Entry(date: Date(), repoEntity: .mock)
  }

  func getSnapshot(in context: Self.Context, completion: @escaping (Self.Entry) -> Void) {
    print("DEBUG:", #function)
    let entry = Entry(date: Date(), repoEntity: .mock)
    completion(entry)
  }

  func getTimeline(in context: Self.Context, completion: @escaping (Timeline<Self.Entry>) -> Void) {
    print("DEBUG:", #function)
    var entries: [Entry] = []

    let currentDate = Date()
    let entry = Entry(date: currentDate, repoEntity: .mockArray.randomElement() ?? .mock)
    entries.append(entry)

    let entryDate = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate) ?? currentDate
    let timeline = Timeline(entries: entries, policy: .after(entryDate))
    completion(timeline)
  }
}
