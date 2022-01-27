//
//  RepoListAction.swift
//  Application
//
//  Created by Yuki Okudera on 2022/01/05.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Domain

enum RepoListAction {
  /// ページ番号を初期化する
  case initializePage
  /// 読み込み結果を反映
  case updateRepoList(RepoAggregateRoot)
  /// エラーメッセージを反映
  case updateErrorMessage(String, String)
  /// エラーを表示
  case showError
}
