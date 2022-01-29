//
//  TabItemView.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/30.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

struct TabItemView: View {
  @State var titleKey: LocalizedStringKey
  @State var systemImageName: String

  var body: some View {
    VStack {
      Image(systemName: systemImageName)
      Text(titleKey, bundle: .current)
    }
  }
}

#if DEBUG
  struct TabItemView_Previews: PreviewProvider {
    static var previews: some View {
      ColorSchemePreview {
        TabItemView(titleKey: "root_view.tab.repositories", systemImageName: "doc.text")
          .previewLayout(.sizeThatFits)
      }
    }
  }
#endif
