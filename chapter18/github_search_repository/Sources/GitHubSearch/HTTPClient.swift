//
//  HTTPClient.swift
//  
//
//  Created by 藤門莉生 on 2023/02/02.
//

import Foundation

/*
 Web APIの呼び出しには、HTTPクライアントが必要
 
 Foundationには、HTTPを含む各種通信に対応したURLSessionクラスがある
 
 実際のアプリケーションではURLSessionクラスを使うとしても、
 テストで実際の通信を行うことは望ましくない
 従って、ここではHTTPクライアントの必要最小限な機能をプロトコルとして定義し、
 スタブを用いたテストができるようにする
 
 HTTPクライアントの最小限の機能は、HTTPリクエストを受け取り、
 HTTPレスポンスもしくはエラーを返すことである。
 
 FoundationではHTTPリクエストはURLRequest型で表し、
 HTTPレスポンスはHTTPボディのData型とHTTPURLResponse型のペアで表す。
 */
public protocol HTTPClient {
    func sendRequest(_ urlRequest: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void)
}

extension URLSession: HTTPClient {
    public func sendRequest(_ urlRequest: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        
        let task = dataTask(with: urlRequest) { data, urlResponse, error in
            switch (data, urlResponse, error) {
            case (_, _, let error?):
                completion(Result.failure(error))
                
            case (let data?, let urlResponse as HTTPURLResponse, _):
                completion(Result.success((data, urlResponse)))
               
            /*
            タプル(data, urlResponse, error)のマッチングの最後のケースは、
            errorがnilでない状況にも、dataとresponseの両方がnilでない状況にもマッチしないケース
             
             このケースは、URLSessionクラスを用いてHTTPリクエストを送信している限りは
             発生しないことがFoudationの実装によって保証されているので、考慮しない
             */
            default:
                fatalError("invalid reponse combination \(String(describing: (data, urlResponse, error)))")
            }
        }
        
        task.resume()
    }
}
