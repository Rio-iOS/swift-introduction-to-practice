/*
 Webサービスとの連携
 
 Twitter、Facebook、GitHub、Slackなどに代表されるWebサービスの多くは、
 その機能の一部を外部のプログラムと連携可能にする仕組みを提供
 */

/*
 連携のための取り決め
 
 Webサービスとの連携では、お互いの命令を理解するために、「クライアント」と「サーバ」間でさまざまな取り決めが必要である。
 
 取り決めの中で最も基本的なものが、「データフォーマット」と「通信するプロトコル」である。
 
 Webサービスとの連携
    - データフォーマット：JSON
    - 通信プロトコル：HTTPS
 
 Swiftでは、コアライブラリであるFoundationを利用すると、JSONの取り扱いやHTTPSによる通信を簡単に実装できる
 */

/*
 データの取り扱い
 
 Data型：バイト列を表す型
 
 Data型は、「バイト列」を表現するための構造体で、ファイルの読み書きや通信など、外部システムとデータをやり取りする際に使用する
 
 バイト列は様々なデータの表現に使用され、画像やJSONもバイト列によって表現される
 */

/*
 エンコードとデコード
 
 エンコード：データを一定の規則に基づいて変換すること
 デコード：エンコードしたデータを元に戻すこと
 
 データをサーバに送信したり、ファイルシステムに保存したりする場合、Swiftの型を対象のシステムが理解できる形式にエンコードする
 
 サーバからデータを受信したり、ファイルシステムからデータを読み込んだりする場合、対象のシステムから取得したデータをSwiftの型にデコードする
 */

/*
 JSONEncoderクラス、JSONDecoderクラス：JSONをエンコードする、デコードする
 
 Foundationには、JSONのエンコーダであるJSONEncoderクラスと、デコーダであるJSONDecoderクラスが用意されている
 
 JSONEncoder：Swiftの値をJSONバイト列にエンコードする
 JSONDecode：JSONバイト列をSwiftの値にデコードする
 
 Swiftの値をJSONEncoderクラスやJSONDecoderクラスを通じて扱うには、
 その型が「Encodableプロトコル」や「Decodableプロトコル」に準拠している必要がある
 */

import Foundation

let encoder = JSONEncoder()
let decoder = JSONDecoder()

let encoded = try encoder.encode(["key": "value"])
let jsonString = String(data: encoded, encoding: .utf8)!
print("エンコード結果：", jsonString)

let decoded = try decoder.decode([String: String].self, from: encoded)
print("デコード結果：", decoded)

/*
 Encodable, Decodable, Codableプロトコル：型をエンコード、デコードに対応させる
 
 特定の型の値をエンコード、デコードするには、その型がEncodableプロトコルとDecodableプロトコルに準拠している必要がある
 
 [プロトコルの定義]
 public protocol Encodable {
    public func encode(to encoder: Encoder) throws
 }
 
 public protocol Decodable {
    public init(from decoder: Decoder) throws
 }
 
 エンコードとデコードの両方に対応させるには、EncodableプロトコルとDecodableプロトコルを組み合わせた
 Codableプロトコルに準拠する
 
 [Codableプロトコルの定義]
 public typealias Codable = Decodable & Encodable
 
 これらのプロトコルに準拠した型は、様々なエンコーダやデコーダによって汎用的に扱える
 */

struct SomeStruct: Codable {
    let value: Int
}

let someStruct = SomeStruct(value: 1)

let jsonEncoder = JSONEncoder()
let encodedJSONData = try! jsonEncoder.encode(someStruct)
let encodedJSONString = String(data: encodedJSONData, encoding: .utf8)!
print("Encoded：", encodedJSONString)

let jsonDecoder = JSONDecoder()
let decodedSomeStruct = try! jsonDecoder.decode(SomeStruct.self, from: encodedJSONData)
print("Decoded：", decodedSomeStruct)

/*
 コンパイラによるコードの自動生成
 
 SomeStruct型は、Encodableプロトコルのencode(to:)メソッドやDecodableプロトコルのinit(from:)メソッドを実装せずに、Codableプロトコルに準拠していた
 これは、「コンパイラがコードを自動生成する」ため
 
 コードの自動生成には条件がある
    - 型がEncodableプロトコルに準拠する場合は、すべてのプロパティの型もEncodableプロトコルに準拠している必要がある
    - 型がDecodableプロトコルに準拠する場合は、すべてのプロパティの型もDecodableプロトコルに準拠している必要がある
 */

// CodableStruct型をコンパイル可能にするには、プロパティの型であるNonCodableStruct型をCondableプロトコルに準拠させるか、encode(to:)メソッドとinit(from:)イニシャライザを独自に実装するかの、いずれかが必要
/*
struct NonCodableStruct{}

// nonCodableStructプロパティの型が
// Codableに準拠していないためコンパイルエラー

struct CodableStruct: Codable {
    let nonCodableStruct: NonCodableStruct
}
*/

/*
 HTTPによるWebサービスとの通信
 
 Foundationは、HTTPによる通信に必要な型を提供
 HTTPリクエストは、「URLRequest型」で表現される
 HTTPレスポンスは、「HTTPURLResponse型」で表現される
 URLRequest型とHTTPURLResponse型を用いて、実際の通信を実行と制御を行うのが、「URLSession型」
 
 HTTPS：HTTPによる通信をSSL（Secure Socket Layer）/TLS（Transport Layer Security）という仕組みで暗号化したもの
 */

/*
 URLRequest型：リクエスト情報の表現
 URLRequest型：通信のリクエストを表現するための型
    - HTTPリクエストのURL、ヘッダ、メソッド、ボディなどの情報をもつ
 
 Acceptヘッダの他にも、クライアントが処理可能なエンコード方式を表すAccept-Encodingや
 クライアントのソフトウェア情報を表すUser-AgentなどのHTTPヘッダが、URLSessionクラスによって自動付与される
 */

let url = URL(string: "https://api.github.com/search/repositories?q=swift")!
var urlRequest = URLRequest(url: url)
// GETリクエストを指定
urlRequest.httpMethod = "GET"
// Acceptヘッダを設定, 受け入れ可能なコンテンツをJSONに設定
urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
print(urlRequest.httpMethod!)
print(urlRequest.allHTTPHeaderFields!)

/*
 HTTPURLResponse型：HTTPレスポンスのメタデータ
 HTTPURLResponse型は、HTTPレスポンスのメタデータを表す型
    - ヘッダやステータスコードなどの情報を持つ
 */

let session = URLSession.shared

let task = session.dataTask(with: urlRequest) { data, urlResponse, error in

    // 受け取ったHTTPレスポンスのメタデータには、dataTask(with:completionHandler:)メソッドの
    // コールバック関数の中でアクセスできる
    // URLResponse型：HTTPURLResponse型のスーパークラス、HTTPに限らない抽象的なレスポンス型
    if let urlResponse = urlResponse as? HTTPURLResponse {
        // ステータスコードの表示
        print(urlResponse.statusCode)
        // ヘッダ情報の表示
        print(urlResponse.allHeaderFields["Date"]!)
        print(urlResponse.allHeaderFields["Content-Type"]!)
    }
}

task.resume()

/*
 URLSessionクラス：URL経由でのデータの送信、取得
 URLSessionクラスは、URL経由でのデータの送信、取得を行う
 タスク：個々のリクエスト
 URLSessionTask：タスクを表す
 */

/*
 3種類のタスク：基本、アップロード用、ダウンロード用
 
 タスク
    - 基本のタスク
    - アップロード用のタスク
    - ダウンロード用のタスク
 
 URLSessionTaskのサブクラスであるURLSessionクラス、URLSessionUploadTaskクラス、URLSessionDownloadTaskクラスが表現する
 
 URLSessionDataTaskクラス
    - iOSでは、バックグラウンドで動作できず、かつサーバから受け取るデータをメモリに保存する
    - 短時間での小さいデータのやり取りを想定している
 
 URLSessionUploadTask
    - バックグラウンドでも動作可能
    - 時間がかかる通信にも適している
 
 URLSessionDownloadTaskクラス
    - サーバからダウンロードしたデータをファイルに保存するため、メモリ使用量を抑えつつ大きいデータを受け取ることができる
 
 [タスクの実行]
 // デフォルト値が設定されたインスタンスを取得
 // キャッシュやCookieなどの動作をより細かく設定したい場合は、新規のインスタンスを生成することもできる
 let session = URLSession.shared

 // URLSessionクラスのdataTask(with:completionHandler:)メソッドに、URLRequest型の値と通信完了時のクロージャを渡してタスクを生成
 
 let task = session.dataTask(with: urlRequest) { data, urlResponse, error in
    // 通信完了時に実行される
 }

 // タスクの実行
 task.resume()
 */
