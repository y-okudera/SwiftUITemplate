//
//  SearchNavigation.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/07.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

struct SearchNavigation<Content: View>: UIViewControllerRepresentable {
  @Binding var text: String
  var search: () -> Void
  var cancel: (() -> Void)?
  var content: () -> Content

  func makeUIViewController(context: Context) -> UINavigationController {
    let navigationController = UINavigationController(rootViewController: context.coordinator.rootViewController)
    navigationController.navigationBar.prefersLargeTitles = true
    context.coordinator.searchController.searchBar.delegate = context.coordinator
    return navigationController
  }

  func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    context.coordinator.update(content: content())
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(content: content(), searchText: $text, search: search, cancel: cancel)
  }

  class Coordinator: NSObject, UISearchBarDelegate {
    @Binding var text: String
    let rootViewController: UIHostingController<Content>
    let searchController = UISearchController(searchResultsController: nil)
    var search: () -> Void
    var cancel: (() -> Void)?

    init(content: Content, searchText: Binding<String>, search: @escaping () -> Void, cancel: (() -> Void)? = nil) {
      rootViewController = UIHostingController(rootView: content)
      searchController.searchBar.autocapitalizationType = .none
      searchController.obscuresBackgroundDuringPresentation = false
      rootViewController.navigationItem.searchController = searchController

      _text = searchText
      self.search = search
      self.cancel = cancel
    }

    func update(content: Content) {
      rootViewController.rootView = content
      rootViewController.view.setNeedsDisplay()
    }

    // MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      text = searchText
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      search()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      cancel?()
    }
  }
}

#if DEBUG
  struct SearchNavigation_Previews: PreviewProvider {
    @State static private var searchQuery = ""
    static var previews: some View {
      ColorSchemePreview {
        SearchNavigation(text: $searchQuery, search: {}) {
          EmptyView()
            .navigationBarTitle(Text("Preview"))
        }
        .previewLayout(.sizeThatFits)
      }
    }
  }
#endif
