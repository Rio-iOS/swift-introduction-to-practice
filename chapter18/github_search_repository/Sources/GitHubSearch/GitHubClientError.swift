//
//  GitHubClientError.swift
//  
//
//  Created by 藤門莉生 on 2023/02/01.
//

/*
 APIクライアントで考えられるエラー
    - URLが不正
    - 通信に失敗
    - 通信に成功しても結果が不正
 */
import Foundation

// 各ケースにError型の連想値を付与
public enum GitHubClientError: Error {
    // 通信に失敗
    // (ex)端末がオフライン, URLのホストが見つからない
    case connectionError(Error)
    
    // レスポンスの解釈に失敗
    // (ex)データがJSONの仕様に沿わない, 期待したJSONのプロパティが欠けている
    case responseParseError(Error)
    
    // APIからエラーレスポンスを受け取った
    case apiError(GitHubAPIError)
}
