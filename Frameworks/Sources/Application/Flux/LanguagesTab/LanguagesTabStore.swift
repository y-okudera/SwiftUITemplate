//
//  LanguagesTabStore.swift
//  Application
//
//  Created by Yuki Okudera on 2022/01/23.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine

/// LanguagesTabは現状Actionが無く、定数管理をしているだけなので、Dispatcher未定義
public final class LanguagesTabStore: ObservableObject {
  public static let shared = LanguagesTabStore()

  @Published public private(set) var languages = [
    "Swift",
    "Kotlin",
    "Dart",
    "Python",
    "C",
    "Java",
    "C#",
    "JavaScript",
    "SQL",
    "PHP",
    "Go",
  ]
}
