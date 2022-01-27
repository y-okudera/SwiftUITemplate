//
//  SpecificLanguageRepoListAction.swift
//  Application
//
//  Created by okudera on 2022/01/20.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Domain

enum SpecificLanguageRepoListAction {
  /// 検索実行したテキストの変更を反映
  case updateSearchQuery(String)
  /// 読み込み結果を反映
  case updateRepoList(LanguagesRepoAggregateRoot)
  /// エラーメッセージを反映
  case updateErrorMessage(String, String)
  /// エラーを表示
  case showError
}
