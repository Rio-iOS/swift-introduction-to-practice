# ユニットテストのセットアップとテストの実行

## ユニットテストのセットアップ
ユニットテストを実行するには、テスト用のビルドターゲットであるテストターゲットが必要  
テストターゲットは、通常のビルドターゲットとは区別され、プログラムの実行方法や配置するディレクトリなどが異なる。  

```
...$ mkdir Demo

...$ cd Demo

// --type library：ライブラリのパッケージを作成するためのオプション
...$ swift package init --type library
```

## Swift Package Mangerのテストの実行
```
...$ swift test
```

```
// --filterオプションを使用して、DemoTests.DemoTests/testExampeleのみを実行
...$ swift test --filter DemoTests.DemoTests/testExample
```
