//
//  UIViewController+.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/30.
//  Copyright © 2022 yuoku. All rights reserved.
//

import UIKit

extension UIViewController {
  @MainActor
  func present(_ viewControllerToPresent: UIViewController, animated isAnimated: Bool) async {
    await withCheckedContinuation { continuation in
      present(viewControllerToPresent, animated: isAnimated) {
        continuation.resume()
      }
    }
  }

  @MainActor
  func dismiss(animated isAnimated: Bool) async {
    await withCheckedContinuation { continuation in
      dismiss(animated: isAnimated) {
        continuation.resume()
      }
    }
  }
}
