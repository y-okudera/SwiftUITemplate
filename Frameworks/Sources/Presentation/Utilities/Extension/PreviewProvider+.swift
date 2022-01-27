//
//  PreviewProvider+.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/24.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

extension PreviewProvider {
  static func resourceUrl(name: String, ofType ext: String, bundle: Bundle = .current) -> URL {
    let path = Bundle.current.path(forResource: name, ofType: ext)!
    return URL(fileURLWithPath: path)
  }
}
