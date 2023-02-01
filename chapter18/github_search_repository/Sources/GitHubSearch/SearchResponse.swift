//
//  SearchResponse.swift
//  
//
//  Created by 藤門莉生 on 2023/02/01.
//

/*
 検索結果のJSONを構造体として定義することを考える
 GitHubの検索APIはリポジトリの検索以外にも利用できる -> ジェネリクス型が活用可能
    - いずれのレスポンスもtotal_countとitemsプロパティを持つ
    - (ex)
    - ユーザー
    - コード
    - etc
 
 Repository型 -> SearchResponse<Respository>
 User型 -> SearchResponse<User>
 */

public struct SearchResponse<Item: Decodable>: Decodable {
    public var totalCount: Int
    public var items: [Item]
}
