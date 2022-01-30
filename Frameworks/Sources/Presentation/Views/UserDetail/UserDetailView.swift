//
//  UserDetailView.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/30.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Application
import Kingfisher
import SwiftUI

struct UserDetailView: View {
  @Environment(\.colorScheme) private var colorScheme

  @ObservedObject private var store: UserListStore
  private let router: Router
  private let userID: String

  init(store: UserListStore = .shared, router: Router, userID: String) {
    self.store = store
    self.router = router
    self.userID = userID
  }

  var body: some View {
    VStack(spacing: 16) {
      ZStack {
        RadialGradient(gradient: Gradient(colors: [.pink, Color.purple.opacity(0.75), .purple]), center: .center, startRadius: 1, endRadius: 300)
          .edgesIgnoringSafeArea(.all)

        VStack {
          KFImage(store.userAggregateRoot.filterByID(userID)?.avatarUrl)
            .cacheOriginalImage()
            .placeholder { ProgressView() }
            .fade(duration: 0.5)
            .resizable()
            .frame(width: 88, height: 88)
            .cornerRadius(44)
            .shadow(color: colorScheme == .light ? .gray : .clear, radius: 2)
          Text(store.userAggregateRoot.filterByID(userID)?.login ?? "")
            .lineLimit(1)
            .foregroundColor(colorScheme == .light ? .black : .white)
            .font(.title)
        }
      }
      .frame(height: UIScreen.main.bounds.height * 0.25)
      Text("id: \(store.userAggregateRoot.filterByID(userID)?.id ?? "")")
        .foregroundColor(colorScheme == .light ? .black : .white)
        .font(.title2)
      Text("type: \(store.userAggregateRoot.filterByID(userID)?.type ?? "")")
        .foregroundColor(colorScheme == .light ? .black : .white)
        .font(.title2)
      Spacer()
    }
  }
}

#if DEBUG
  struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
      AppPreview {
        UserDetailView(
          store: .mock(mockAvatarUrl: resourceUrl(name: "octocat", ofType: "png")),
          router: Router(isPresented: .constant(true)),
          userID: "0"
        )
      }
    }
  }
#endif
