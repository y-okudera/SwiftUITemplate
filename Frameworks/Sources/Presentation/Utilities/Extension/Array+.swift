//
//  Array+.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/18.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

extension Array {
  subscript(safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
