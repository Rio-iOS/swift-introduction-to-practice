# GitHub Search API Client

## GitHub API
```
# (ex)
# ウェブブラウザで以下を入力する
https://api.github.com/orgs/octokit/repos
```

## GitHub Search API
- URL: https://docs.github.com/ja/rest/search?apiVersion=2022-11-28

```
# クエリーパラメータ「?q=xxx」が必須
# クエリーパラメータ「per_page」で取得件数を指定できる
https://api.github.com/search/repositories?q=swift
```

## コマンドラインアプリケーションのパッケージ作成
- GitHubSearch：GitHub APIを操作する処理をまとめたライブラリのビルドターゲット
- GitHubSearchTests：GitHubSearchのテストターゲット
- github_search_repository：GitHubSearchを利用する実行ファイルのビルドターゲット

### ビルドターゲットをライブラリと実行ファイルにわける目的
- ユニットテストを行うため
    - 実行ファイルに含まれる型や関数には他のビルドターゲットからアクセスできないため、型を使用したテストができない
    - 一方、ライブラリでは公開されている型を使用したテストが可能
    - したがって、ロジック部分の大部分はライブラリに記述する

### 作成手順
```
...$ mkdir github_search_repository

...$ cd github_search_repository

...$ mkdir -p Sources/GitHubSearch

...$ mkdir -p Tests/GitHubSearchTests

...$ mkdir Sources/github_search_repository

...$ touch Package.swift
```

### Package.swiftの内容
```
// swift-tools-version:5.5.2

import PackageDescription

let package = Package(
   name: "github_search_repository",
   targets: [
    .target(
       name: "GitHubSearch"
    ),
    .testTarget(
       name: "GitHubSearchTests",
       dependencies: ["GitHubSearch"]
    )
    .target(
       name: "github_search_repository",
       dependencies: ["GitHubSearch"]
    ),
   ]
)
```

### テストの実行
```
...$ swift test
```

### プログラムの実行
```
...$ swift run
```

## API仕様のモデル化
- 構成要素
    - リクエスト
    - レスポンス
    - エラー

## エラーレスポンスのモデル化
- WebAPIでは、サーバ側でエラーが発生した場合にエラーを表すレスポンスを返す
- HTTPステータス400番台（クライアントエラー）, 500番台（サーバエラー）

## リクエスト：サーバに対する要求の表現
- リクエスト：クライアントがサーバに送信するデータや処理の依頼のこと
- 通常、Web APIではどのようなリクエストを送ればどのようなレスポンスが得られるかを仕様として定義し、その仕様に沿ってクライアントとサーバで連携を行う。
- リクエストの型に必要なものをGitHubRequestプロトコルとしてまとめる。
- GitHubRequestプロトコルに準拠する型はWeb APIの仕様を表現することになるので、そのプロパティは書き換え不可能であるべき。
- Web APIを呼び出す側のアプリケーションが、Web APIのURLを変更するということはない。
- このような理由から、GitHubRequestプロトコルが要求するプロパティは必然的にゲッタとなる。
- ベースURL：相対パスの基準となるURL

## HTTPメソッドの定義
- HTTPメソッド：Web上のリソースを「どのように」操作するかを指定する

## パラメータの定義
- Web APIに対して条件を指定したり、特定のデータを送信したりする際にそれらをリクエストパラメータとして渡す
- GitHub API
    - q：検索キーワード
    - per_page：最大件数
- Foundationには、クエリ文字列を表すための「URLQueryItem型」が用意されている
- POSTリクエストやPUTリクエストなどでは、パラメータをJSONとして表現し、HTTPボディにセットしてサーバに送信する
    - (ex)
    - リポジトリのタイトルや説明を含むJSONをPOSTリクエストで送信することで新規のリポジトリを作成できる



## APIクライアント：Web API呼び出しの抽象化
- APIクライアントは、リクエストの情報をもとにWeb APIを呼び出し、そのレスポンスを呼び出しもとに返す
- APIクライアントは、リクエストを表す型から実際のリクエストを生成し、受け取ったレスポンスをレスポンスを表す型へと変換する役割を果たす。
- Web APIとのやり取りはHTTPで行われるため、APIクライアント内部では、Foundationが提供するHTTPクライアントを使用する
