//
//  WidgetEntry.swift
//  Widget
//
//  Created by Yuki Okudera on 2022/02/11.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Domain
import WidgetKit

struct WidgetEntry: TimelineEntry {
  let date: Date
  let repoEntity: RepoEntity
}
