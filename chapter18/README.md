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
