//
//  DevicePreview.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/24.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

struct DevicePreview<Content>: View where Content: View {
  let content: () -> Content

  private let previewDevices = [
    "iPhone SE (1st generation)",
    "iPhone 8",
    "iPhone 13 Pro Max",
    "iPad Pro (11-inch) (3rd generation)",
  ]

  var body: some View {
    ForEach(previewDevices, id: \.self) { previewDevice in
      content()
        .previewDevice(PreviewDevice(rawValue: previewDevice))
        .previewDisplayName(previewDevice)
    }
  }
}
