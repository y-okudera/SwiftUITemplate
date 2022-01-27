//
//  Error+.swift
//  Domain
//
//  Created by Yuki Okudera on 2022/01/08.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

extension Error {
  var reflectedString: String {
    return String(reflecting: self)
  }

  func isEqual(to: Error) -> Bool {
    return reflectedString == to.reflectedString
  }
}
