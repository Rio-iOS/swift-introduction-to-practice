/*
 非同期処理
    - 複数の処理を並列化することで効率の良いプログラムを実現する
    - 適切に実装しなければ、保守性が低いコードになりやすく、バグの温床となりがち
 */

/*
 Swiftにおける非同期処理
 
 非同期処理：実行中に別の処理を止めない処理
    - ある処理を行なっている間に、その終了を待たずに別の処理を実行できる
    - 処理の高速化やレスポンシブなGUIの実現につながる
 
 Swiftでは、スレッドを利用して非同期処理を実現
 
 スレッド：CPU利用の仮想的な実行単位
    - プログラムはメインスレッドという単一のスレッドから開始
    - メインスレッドから別のスレッドを作成することもでき、そこで行われる処理はメインスレッドの処理とは並列に実行される
 
 マルチスレッド処理：複数のスレッドを使用して処理を並列に行うこと
    - 正しく実装しなければ、深刻な問題を招くプログラミング手法
    - スレッドの過度な使用により、メモリが枯渇
    - 複数のスレッドから同一のデータを更新しようとして不整合が発生
    - スレッドが互いに待合を行うデッドロックが発生
 
 複数のスレッドがどのように実行されるかをプログラマーが把握し、管理しないといけない
 
 スレッドそのものを操作するために、コアライブラリのFoundationは「Thread」というクラスを提供
 同じくコアライブラリである「libdispatch」が提供する「GCD」によって、スレッドを直接操作しなくても容易に非同期処理が行えるようになっている
 「libdispatch」を利用するには、Dispatchモジュールをインポートする必要がある
 
 GCD：C言語ベースの低レベルAPI
 Foundationのクラスとして提供したOperation、OperationQueueもある
 
 非同期処理を行う方法
    - GCDを用いる方法
    - Operation、OperaionQueueクラスを用いる方法
    - Threadクラスを用いる方法
 */

/*
 GCD：非同期処理のための低レベルAPI群
 
 GCD（Grand Central Dispatch）：iOS4.0、Mac OS X10.6から導入された、非同期処理を用意するためのC言語ベースのシステムレベル
    - GCDではキューを通じて非同期処理を行い、直接スレッドを管理することはない
    - スレッドの管理はシステムが管理し、CPUのコア数や負荷の状況などを考慮して自動的に処理を最適化する
    - 処理の並列数やスケジューリングや、どの処理がどのスレッドで実行されるかなどについてプログラマーが考える必要はない
    - プログラマーが行う必要があるのは、タスクをキューへと追加するだけ
 キューに追加されたタスクはそれぞれ適切なスレッドで実行されるが、これらのスレッドは都度生成されるわけではない
 あらかじめ用意されたスレッドの中から、空いているスレッドにタスクが割り振られ、もし空いているスレッドがなければスレッドが空くまで待機する
 
 スレッドプール：あらかじめ準備されたスレッドを使い回すスレッド管理の手法
 */

/*
 ディスパッチキューの種類
 ディスパッチキュー：GCDのキュー
 
 ディスパッチキューはタスクの実行方式によって2種類に大別される
    - 直列ディスパッチキュー（serial dispatch queue）
        - 現在実行中の処理を待ってから、次の処理を実行する
 
    - 並列ディスパッチキュー（concurrent dispatch queue）
        - 現在実行中の処理の終了を待たずに、次の処理を並列して実行する
 
 ディスパッチキューを利用するには、既存のディスパッチキューを取得するか、新規のディスパッチキューを生成する
 */

/*
 既存のディスパッチキューの取得
 
 GCDは既存のディスパッチキュー
    - メインキュー（main queue）：メインスレッドでタスクを実行する直列ディスパッチキュー
    - グローバルキュー（global queue）
 
 メインキューの取得は、DispatchQueue型のmainクラスプロパティを通じて行う
 
 
 iOSやmacOS向けのアプリケーションでは、「ユーザーインタフェースの更新は常にメインキュー」で実行される
 他のディスパッチキューで実行した非同期処理の結果をユーザーインタフェースへ反映させる場合、メインキューを取得してタスクを追加することになる
 
 グローバルキューは並列ディスパッチキューで、実行優先度を指定して取得する
 QoS（Quality of Service）：実行優先度
 
 優先度（高い順）
    - userInteractive：アニメーションの実行など、ユーザーからの入力に対してインタラクティブに実行され、即時に実行されなければフリーズしているように見える処理に用いる
 
    - userInitiated：ユーザーインタフェース上の何かをタップした場合など、ユーザーからの入力を受けて実行される処理などに用いる
 
    - default：userInitiatedとutilityの中間の実行優先度。QoSが何も指定されていない場合に利用される。明治的に指定するべきではない
 
    - utility：プログレスバー付きのダウンロードなど、視覚的な情報の更新を伴いながらも、即時の結果を要求しない処理に用いる
 
    - background：バックアップなど、目に見えないところで行われていて、数分から数時間かかっても問題ない処理に用いる
 
 QoSは列挙型DispatchQoS.QoSClassとして以下のように定義されている
 
 public struct DispatchQoS: Equatable {
    (省略)
 
    public enum QoSClass {
        case background
        case utility
        case `default`
        case userInitiated
        case userInteractive
 
        (省略)
    }
 }
 */

/*
 Swiftでは一部のキーワードは予約語となっており、変数や型の名前として利用できない
 予約語は、「`（バッククオート）」で囲むことで名前として利用できる
 defaultが「`」で囲まれているのは、defaultキーワードがswitch文でデフォルトケースを指定するための予約語となっている
 */

/*
 グローバルキューの取得は、DispatchQueue型のglobal(qos:)クラスメソッドを通じて行い、
 引数にはDispatch.QoSClass型の値を指定する
 */

/*
 専用のディスパッチキューを必要とする非同期処理でなければ、通常はグローバルキューを使う
 */
import Dispatch

// メインディスパッチキュー
let queue = DispatchQueue.main

// ディスパッチキュー
let queue2 = DispatchQueue.global(qos: .userInitiated)

/*
 新規のディスパッチキューの生成
 DispatchQueue型のイニシャライザ
 
 // com.my_company.my_app.upload_queueという名前の並列ディスパッチキューを生成
 // 引数label：ディスパッチキューの名前を指定する
 // この名前はXcode上でのデバッグ時に参照できるので、適切な名前を設定しておく
 // 通常、名前には逆順DNS（Domain Name System）形式のものを使用する
 // com.my_company.my_app.upload_queueでは、トップレベルドメイン.会社名.アプリケーション名.キューの役割
 // 逆順DNS形式を用いる目的は、名前を一意に指定することにある
 // 逆順DNS形式により、他のライブラリで使用されているキューとの名前の重複を防げる
 // 引数qos：生成するディスパッチキューのQoSを指定する
 // 引数attributesには、さまざまなオブションが追加でき、生成するディスパッチキューを直列にするか並列にするかもこの引数で指定する
 // []の中に.concurrentを追加すると並列ディスパッチキューが生成され、追加しなければ直列ディスパッチキューが生成される
 
 
 let queue = DispatchQueue(
    label: "com.my_company.my_app.upload_queue",
    qos: .default,
    attributes: [.concurrent]
 )
 */

/*
 ディスパッチキューへのタスクの追加
 
 取得あるいは、生成したディスパッチキューにタスクを追加するには、DispatchQueue型のasync(execute:)メソッドを用いる。
 ディスパッチキューではタスクはクロージャで表され、async(execute:)メソッドの引数となっている。
 直列ディスパッチキューも並列ディスパッチキューもタスクの追加方法は同様である
 
 (ex)
 並列ディスパッチキューに対してasync(execute:)メソッドを呼び出して非同期処理を行なっている
 ThreadクラスのisMainThreadクラスプロパティの値を確認することで、現在の処理がメインスレッド上で行われているかを問い合わせすることができる。
 */

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let queue3 = DispatchQueue.global(qos: .userInitiated)

queue3.async {
    print(Thread.isMainThread)
    print("非同期の処理")
}

/*
 利用するべきとき
 
 シンプルな非同期処理を実装する
 GCDではタスクをクロージャとして表現できるため、単純な非同期処理の実装に向いている
 メインスレッドから時間のかかる処理を別のスレッドに移し、その処理が終わればメインスレッドに通知する
 
 このような挙動は、DispatchQueue型のglobal(qos:)クラスメソッド、async(execute:)メソッド、mainクラスプロパティを組み合わせることで実現できる
 
 特定の処理を別のスレッドに移したいだけというような典型的な非同期処理のケースでは、GCDの利用を検討してみる
 タスクどうしの依存関係の定義や、条件に応じたキャンセルをGCDで実装するのは容易ではない
 そのような複雑な非同期処理を実装する場合は、OperationクラスとOperationQueueクラスの利用を検討する
 */

var queue4 = DispatchQueue.global(qos: .userInitiated)

queue4.async {
    print(Thread.isMainThread)
    print("非同期処理")
}

queue4 = DispatchQueue.main
queue4.async {
    print(Thread.isMainThread)
    print("メインスレッドでの処理")
}


/*
 Operaion、OperationQueueクラス：非同期処理を抽象化したクラス
 
 GCDは、コアライブラリのlibdispatchで実装されている
 Foundationにも非同期処理を実現するクラスのOperation、OperaionQueueがある
 
 Operationクラス：実行されるタスクとその情報をカプセル化したもの
    - Operationクラスのインスタンスがキューに入れられて順次実行される
 OperationQueue：キューの役割を果たす
 
 タスクの定義
 タスクはOperaionクラスのサブクラスとして定義する
 GCDでは、タスクをクロージャとして表していたが、Operationクラスではこれをクラスとして表すことによって扱いやすいインタフェースを提供している
 
 Operationクラスの処理は、main()メソッドの中に実装
 */

class SomeOperation: Operation {
    let number: Int
    
    init(number: Int) {
        self.number = number
    }
    
    override func main() {
        // 1秒待つ
        Thread.sleep(forTimeInterval: 1)
        print(number)
    }
}

/*
 キューの生成
 
 タスクを実行するキューとなるOperationQueueクラスのインスタンスを生成
 OperationQueueは、引数なしのイニシャライザでインスタンス化でき、各種設定はあとからプロパティ経由で設定する

 nameプロパティを設定するにとキューに名前をつけることができる
    - この値には、GCDと同様に逆順DNS形式を使用することが一般的である
 
 特定のキューが同時に実行されるタスクの数はシステムの状況から適切に判断されるが、
 maxConcurrentOperationCountプロパティに値を設定することで、自分でその数を決めることができる
 非現実的なほど大きな数を設定しても、高速になるわけではない
 
 GCDのQoSに相当する実行優先度を表すQualityOfService型も用意されており、qualityOfServiceプロパティに
 QualityOfService型の値を設定することで実行優先度を設定できる
 QualityOfService型のそれぞれの値の役割は、GCDの同名のQoSと同様である
 
 [QualityOfServiceの定義]
 public enum QualityOfService: Int {
    case userInteractive
    case userInitiated
    case utility
    case background
    case `default`
 }
 
 GCDのメインキューのように、OperationQueueクラスもメインスレッドでタスクを実行するキューOperationQueue.mainを持っている
 GCDのグローバルキューのように汎用的な非同期処理のためのあらかじめ用意されたキューは存在しない
 */

// キューの生成
let queue5 = OperationQueue()

let queue6 = OperationQueue()
queue6.name = "com.example.my_operation_queue"
queue6.maxConcurrentOperationCount = 2
queue6.qualityOfService = .userInitiated


/*
 キューへのタスクの追加
 
 キューへタスクを追加するには、OperationQueueクラスのaddOperation(:_)メソッドを使用し、
 引数にはOperationクラスの値を渡す。
 
 OperationQueueクラスには複数のOperationクラスの値を渡すためのaddOperation(_:waitUntilFinished:)メソッドも用意されており、このメソッドの第1引数の型は[Operation]型となっている
 */

PlaygroundPage.current.needsIndefiniteExecution = true

class SomeOperation2: Operation {
    let number: Int
    init(number: Int) {
        self.number = number
    }
    
    override func main() {
        // 1秒待つ
        Thread.sleep(forTimeInterval: 1)
        print(number)
    }
}

let queue7 = OperationQueue()
queue7.name = "com.example.my_operation_queue"
// タスクは最大2個まで並列に実行される
// 1から10までの数値が2つずつ1秒おきに出力される
queue7.maxConcurrentOperationCount = 2
queue7.qualityOfService = .userInitiated

var operations = [SomeOperation2]()

for i in 1...10 {
    operations.append(SomeOperation2(number: i))
}

queue7.addOperations(operations, waitUntilFinished: false)
print("Operations are added")

/*
 タスクのキャンセル
 
 Operationクラスにはタスクをキャンセルするためのしくみが備わっている
 
 cancel()メソッドを呼び出すことで、タスクに対してキャンセルを伝える
 しかし、これだけで実際にタスクの実行がキャンセルされるわけではない。
 Operationクラスのサブクラスにキャンセル時の処理を追加する必要がある。
 
 isCancelledプロパティ：タスクがキャンセルされたかどうかを判定できる
 */


PlaygroundPage.current.needsIndefiniteExecution = true

class SomeOperation3: Operation {
    let number: Int
    init(number: Int) {
        self.number = number
    }
    
    override func main() {
        Thread.sleep(forTimeInterval: 1)
        
        guard !isCancelled else { return }
        
        print(number)
    }
}

let queue8 = OperationQueue()
queue8.name = "com.example.my_operation_queue"
queue8.maxConcurrentOperationCount = 2
queue8.qualityOfService = .userInitiated

var operations2 = [SomeOperation3]()

for i in 0..<10 {
    operations2.append(SomeOperation3(number: i))
}

queue8.addOperations(operations2, waitUntilFinished: false)

operations2[6].cancel()

/*
 タスクの依存関係の設定
 
 Operationクラスは複数のタスク間での依存関係を設定するためのインタフェースを持っている
 あるタスクに対して、それよりも先に実行されるべきタスクを指定するには、
 OperationクラスのaddDependency(_:)メソッドで先に実行されるべきタスクを引数に渡す
 */

class SomeOperation4: Operation {
    let number: Int
    
    init(number: Int) {
        self.number = number
    }
    
    override func main() {
        Thread.sleep(forTimeInterval: 1)
        if isCancelled { return }
        
        print(number)
    }
}

let queue9 = OperationQueue()
queue9.name = "com.example.my_operation_queue"
queue9.maxConcurrentOperationCount = 2
queue9.qualityOfService = .userInitiated

var operations3 = [SomeOperation4]()

for i in 0..<10 {
    operations3.append(SomeOperation4(number: i))
    
    if i > 0 {
        operations3[i].addDependency(operations3[i-1])
    }
}

queue9.addOperations(operations3, waitUntilFinished: false)

/*
 Operation, OperationQueueクラスを利用するべきとき
 
 複雑な非同期処理を実装する
 Operation、OperationQueueクラスは、非同期処理をオブジェクト指向で抽象化したもの
 単純なスレッドの切り替えのほかにも、タスクの依存関係の定義やキャンセルなどの機能が備わっているため、
 複雑な非同期処理に向いている
 
 Operation、OperationQueueクラスは内部ではGCDを利用しているので、
 基本的にGCDで実現できることは、Operation、OperationQueueクラスでも実現できる
 
 Operation、OperationQueue
    - タスクの定義やキューの生成が必須
    - タスクのキャンセルとタスク間の依存関係の設定に関しては、Operation、OperationQueueクラスを用いた方が容易に実装できる
    - キャンセルや依存関係を実装する必要がある場合は、Operation、OperationQueueクラスの利用を検討する
 
 GCD
    - タスクはクロージャで表され、キューを生成しなくてもグローバルキューを利用できる
    - 単純な非同期処理を実装する場合、GCDを利用する方がよい
 */

/*
 Threadクラス：手動でのスレッド管理
 GCDやOperation、OperationQueueクラスはキューを通じてタスクの管理を行い、スレッドの管理はシステムに任せる
 
 Foundationでは、スレッドそのものをThreadクラスとして実装している
    - スレッドの生成と制御をプログラマー自身で行う
 
 [実装方法]
 Threadクラスのサブクラスを実装することで、自分自身でスレッドを定義できる
 スレッドのエントリポイントは、main()メソッドをオーバーライドして実装する
 Threadクラスのインスタンスはstart()メソッドを呼び出す
 
 
 カレントスレッド：処理を実行しているスレッド
 
 Threadクラスにはカレントスレッドを操作するための機能が用意されている
    - sleep(forTimeInterval:)クラスメソッド
        - このメソッドが実行されているスレッドを、指定して秒数だけ停止させる
    
    - sleep(until:)クラスメソッド
        - 時刻を表すDate型の値を引数に取り、その時刻までカレントスレッドを休止させる
 
    - exit()クラスメソッド
        - カレントスレッドの実行を途中で終了する
    - isMainThreadクラスプロパティ
        - カレントスレッドがメインスレッドかどうかを判定する
 */

/*
 利用するべきとき
 
 特になし
 スレッドを利用する多くのケースでは、スレッドの作成、管理そのものよりも、非同期処理によって
 パフォーマンスやユーザビリティを改善することが目的となる
 
 そのような場合には、複雑かつバグを生みやすいスレッドの管理をシステムレベルで行なってくれるGCDやOperation、OperationQueueクラスを利用するべき
 
 Threadクラスを利用してスレッドの管理を手動で行う必要があるケースはまれ
 */

/*
 非同期処理の結果のイベント通知
 非同期処理の開始や終了のイベントを非同期処理の呼び出し元に通知したい場合、イベント通知を用いる
 
 非同期処理の結果の最も一般的な方法は、クロージャを用いたもの
    - runAsynchronous()関数は、結果をクロージャの引数として呼び出し元に伝える
 */
class SomeThread: Thread {
    override func main() {
        print("executed.")
    }
}

let thread = SomeThread()
thread.start()

func runAsynchronousTask(handler: @escaping (Int) -> Void) {
    let globalQueue = DispatchQueue.global()
    
    globalQueue.async {
        // 合計を求める
        let result = Array(0...1000000).reduce(0, +)
        
        let mainQueue = DispatchQueue.main
        mainQueue.async {
            // 結果をクロージャの引数として呼び出し元に伝える
            handler(result)
        }
    }
}

runAsynchronousTask { result in
    print(result)
}
