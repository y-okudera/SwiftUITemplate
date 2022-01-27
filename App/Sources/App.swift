//
//  App.swift
//  App
//
//  Created by Yuki Okudera on 2022/01/01.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Presentation
import SwiftUI

@main
struct App: SwiftUI.App {
  // AppDelegateを参照
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
    WindowGroup {
      RootView()
    }
  }
}
