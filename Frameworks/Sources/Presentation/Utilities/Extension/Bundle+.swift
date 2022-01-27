//
//  Bundle+.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/19.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

extension Bundle {
  static var current: Bundle {
    class DummyClass {}
    return Bundle(for: type(of: DummyClass()))
  }
}
