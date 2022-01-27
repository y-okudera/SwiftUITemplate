//
//  UserListAction.swift
//  Application
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Domain

enum UserListAction {
  /// ページ番号を初期化する
  case initializePage
  /// 読み込み結果を反映
  case updateUserList(UserAggregateRoot)
  /// エラーメッセージを反映
  case updateErrorMessage(String, String)
  /// エラーを表示
  case showError
}
