//
//  File.swift
//  
//
//  Created by 藤門莉生 on 2023/02/02.
//
import Foundation

/*
 リクエストを表す型をGitHub APIクラスを用いてグルーピングした。
 このように型のネストを利用することで、論理的な階層構造を表現できる
 
 (ex)
 新たなユーザー検索のリクエストを表す「SearchUser型」を定義するとする
 この時、SearchRepositories型やSearchUesrs型にアクセスする場合は、
 GitHubAPI.SearchRepositoriesやGitHubAPI.SearchUsersというように表記する必要がある
 それぞれのリクエストがGitHub APIに属していることが一目瞭然である。
 
 【重要】特にアプリケーションの内部で複数のサービスが提供するAPIを使用する場合などに効果的
 
 
 GitHubAPIクラスは、オーバーライドを想定しないため、finalキーワードを追加し、
 オーバーライドを禁止している
 */
public final class GitHubAPI {
    public struct SearchRepositories: GitHubRequest {
        // keywordは、メンバーワイズイニシャライザで初期化
        public let keyword: String
        
        public init(keyword: String) {
            self.keyword = keyword
        }
        
        // GitHubRequestが要求する連想型
        public typealias Response = SearchResponse<Repository>
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "/search/repositories"
        }
        
        public var queryItems: [URLQueryItem] {
            return [URLQueryItem(name: "q", value: keyword)]
        }
    }
    
    public struct SearchUsers: GitHubRequest {
        public let keyword: String
        
        public typealias Response = SearchResponse<User>
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "/search/users"
        }
        
        public var queryItems: [URLQueryItem] {
            return [URLQueryItem(name: "q", value: keyword)]
        }
    }
}
