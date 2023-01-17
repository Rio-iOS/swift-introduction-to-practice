import Foundation

/*
 型の構成要素
    - プロパティ、イニシャライザ、メソッド
 
 Swiftの型
    - クラス
    - 構造体
    - 列挙型
 
 「標準ライブラリの型」の多くは、「構造体」として定義されている
 「Cocoaのほとんどの型」は「クラス」として定義されている
 
 クラス、構造体、列挙型の3つは、メソッドやプロパティなどの共通要素が用意されている
 */

/*
 型に共通するもの
    - 代表的な型を構成する要素
        - 値を保存するプロパティ：型に紐づいた変数や定数
        - 振る舞いを表すメソッド：型に紐づいた関数
        - イニシャライザ：初期化を行う
        - サブスクリプト：コレクションの要素を取得する
        - 型内に型を定義するネスト型
 */

/*
 型の基本
    - 型の定義方法
    - インスタンス化
 
 インスタンス：型を実体化したもの
    - プロパティ
    - メソッド
 
 [構造体]
 struct 構造体名 {
    // 構造体の定義
 }
 
 [クラス]
 class クラス名 {
    // クラスの定義
 }
 
 [列挙型]
 enum 列挙型名 {
    // 列挙型の定義
 }
 
 インスタンス化の方法
    - 型をインスタンス化するには、型名に()を付けてイニシャライザを呼び出す
        - ()内には、必要に応じてイニシャライザの引数を渡す
    - 列挙型では、デフォルトにイニシャライザが定義されていないため、SomeEnum()で初期化できない
        - 代わりに、列挙型にはケースを指定するというインスタンス化の方法が用意
 
 [インスタンス化]
 型名()
 
 
 型の内部でのインスタンスへのアクセス
    - 型の内部のプロパティやメソッドの中では、「selfキーワード」を通じてインスタンス自身にアクセスできる
    - インスタンスそのものではなく、インスタンスのプロパティやメソッドにアクセスする場合「selfキーワード」を省略できる
    - インスタンスのプロパティと同名の変数や定数がスコープ内に存在する場合は、それらを区別するために「selfキーワード」を「明記」する必要がある
 
 
 型の内部での型自身へのアクセス
    - Selfキーワード：型自身に紐づくメンバーである、スタティックプロパティやスタティックメソッドへのアクセスが簡単になる
 */

// 構造体
struct SomeStruct {}

// クラス
class SomeClass {}

// 列挙型
enum SomeEnum {}

// インスタンス化
let someStruct = SomeStruct()
let someClass = SomeClass()


// selfキーワード
struct SomeStruct2 {
    let value = 123
    
    func printValue() {
        print(self.value)
    }
}

// selfキーワードの省略
struct SomeStruct3 {
    let value: Int

    func printValue() {
        // selfの省略
        print(value)
    }
}


// selfの明記
struct SomeStruct4 {
    let value: Int
    
    // 同名の変数が存在する場合は、selfを明記する
    init(value: Int) {
        self.value = value
    }
}


// スタティックプロパティへのアクセス
struct SomeStruct5 {
    static let sharedValue: Int = 73
    
    func printSharedValue() {
        print(Self.sharedValue)
    }
}

/*
 プロパティ：型に紐づいた値
    - 型が表すものの属性の表現などに使用される
 
 [定義]
 struct 構造体名 {
    var プロパティ名: プロパティの型 = 式 //再代入可能なプロパティ
    let プロパティ名: プロパティの型 = 式 //再代入不可能なプロパティ
 }
 
 [プロパティへのアクセス]
 変数名.プロパティ名
 
 
 インスタンス化完了までに、全てのプロパティに値が代入されている必要がある
    - 宣言時に初期値を持っている
    - イニシャライザで初期化される
 
 
 紐づく対象による分類
 プロパティ
    - インスタンスプロパティ：型のインスタンスに紐づく
        - インスタンスごとに異なる値を持たせることができる
        - インスタンスが生成されるまでに値を代入できれば良いため、イニシャライザで初期化できる
    - スタティックプロパティ：型そのものに紐づく
        - インスタンスではなく、型自身に紐づくプロパティ
        - インスタンス間で共通する値の保持などに使用できる
        - staticキーワードを追加
        - イニシャライザに相当する初期化のタイミングがないため、宣言時に必ず初期値を持たせる必要がある
 */

struct SomeStruct6 {
    var variable = 123
    let content = 456
}

let someStruct2 = SomeStruct6()
let a = someStruct2.variable
let b = someStruct2.content
print(a)
print(b)

// インスタンスプロパティ
struct Greeting {
    var to = "Rio Fujimon"
    var body = "Hello!"
}

let greeting1 = Greeting()
var greeting2 = Greeting()
greeting2.to = "Rio"
let to1 = greeting1.to
let to2 = greeting2.to
print(to1)
print(to2)

// スタティックプロパティ
struct Greeting2 {
    static let signature = "Sent from iPhone"
    
    var to = "Rio Fujimon"
    var body = "Hello!"
}

func print(greeting: Greeting2) {
    print("to: \(greeting.to)")
    print("body: \(greeting.body)")
    print("signature: \(Greeting2.signature)")
}

let greeting3 = Greeting2()
var greeting4 = Greeting2()
greeting4.to = "Rio"
greeting4.body = "Hi!"

print(greeting: greeting3)
print("--")
print(greeting: greeting4)

/*
 // staticプロパティが初期値を持たないため、コンパイルエラー
 struct Greeting {
    // 値を持っていないためコンパイルエラー
    static let signature: String
 }
 */

/*
 ストアドプロパティ；値を保持するプロパティ
    - 変数や定数のように値を代入して保存するプロパティ
 
 [定義]
 var インスタンスプロパティ名: プロパティの型 = 式
 let インスタンスプロパティ名: プロパティの型 = 式
 static var インスタンスプロパティ名: プロパティの型 = 式
 static let インスタンスプロパティ名: プロパティの型 = 式
 
 プロパティ
    - ストアドプロパティ：値を保持するプロパティ
    - コンピューテッドプロパティ：値を保持しないプロパティ
 */


// ストアドプロパティ
struct SomeStruct7 {
    var variable = 123 // 再代入可能
    let constant = 456 // 再代入不可能
    static var staticVariable = 789 // 再代入可能。型自身に紐づく
    static let staticConstant = 890 // 再代入不可能。型自身に紐づく
}

let someStruct3 = SomeStruct7()
print(someStruct3.variable)
print(someStruct3.constant)
print(SomeStruct7.staticVariable)
print(SomeStruct7.staticConstant)


/*
 プロパティオブザーバー：ストアドプロパティの変更の監視
    - ストアドプロパティの値の変更を監視し、変更前と変更後に文を実行するもの
 
 プロパティオブザーバー
    - willSetキーワード
        - willSetの時点では、ストアドプロパティは更新されない
        - 暗黙的な定数newValueを通じて新しい値にアクセスできる
    - didSetキーワード
 
 [定義]
 var プロパティ名 = 初期値 {
    willSet {
        // プロパティの変更前に実行する文
        // 変更後の値には、定数newValueとしてアクセスできる
    }
 
    didSet {
        // プロパティの変更後に実行する文
    }
 }
 */

// プロパティオブザーバー
struct Greeting3 {
    var to = "Rio Fujimon" {
        willSet {
            print("willSet: (to: \(self.to), newValue: \(newValue))")
        }
        
        didSet {
            print("didSet: (to: \(self.to))")
        }
    }
}

var greeting5 = Greeting3()
greeting5.to = "Rio"

/*
 レイジーストアドプロパティ：アクセス時まで初期化を遅延させるプロパティ
    - varキーワードの前に「lazyキーワード」を追加する
    - letキーワードによる再代入不可能なプロパティでは使用できない
    - 初期化コストの高いプロパティの初期化をアクセス時まで延ばし、アプリケーションのパフォーマンスを向上させることができる
    - 通常、ストアドプロパティの初期化時に他のプロパティやメソッドを利用することはできない。しかし、レイジーストアドプロパティの初期化はインスタンスの生成よりも後に行われるため、初期化時に他のプロパティやインスタンスにアクセスできる
 
 [定義]
 lazy var インスタンスプロパティ名: プロパティの型 = 式
 static lazy var インスタンスプロパティ名: プロパティの型 = 式
 */


// レイジーストアードプロパティ
struct SomeStruct8 {
    var value: Int = {
        print("valueの値を生成します")
        return 1
    }()
    
    lazy var lazyValue: Int = {
        print("lazyValueの値を生成します")
        return 2
    }()
}

var someStruct4 = SomeStruct8()
print("SomeStructをインスタンス化しました")
print("valueの値は\(someStruct4.value)です")
print("lazyValueの値は\(someStruct4.lazyValue)です")

// レイジーストアドプロパティによるプロパティへのアクセス
struct SomeStruct9 {
    var value = 1
    // lazyキーワードにより、valueを利用して、初期化ができる
    lazy var lazyValue = double(of: value)
    
    func double(of value: Int) -> Int {
        return value * 2
    }
}


/*
 コンピューテッドプロパティ：値を保持せずに算出するプロパティ
    - プロパティ自身では、値を保持せずに、すでに存在するストアドプロパティなどから計算して値を返すプロパティ
    - コンピューテッドプロパティは、アクセスごとに値を計算し直すため、計算元の値との整合性が常に保たれる
    - ゲッター：getキーワード
        - 他のストアドプロパティなどから値を取得して、コンピューテッドプロパティの値として返す処理
        - 値の返却には、return文を返す
        - コンピューテッドプロパティでは、ゲッタの定義は必須である
        - セッタが存在しない場合は、getキーワードと{}を省略してゲッタを記述することができる
    - セッター：setキーワード
        - プロパティに代入された値を使用して、他のストアドプロパティなどを更新する処理
        - 暗黙的に宣言されたnewValueという定数を通じて代入された値にアクセスできる
        - セッタを持つコンピューテッドプロパティは、インスタンスの更新方法が複数あるが、プロパティ同士の整合性を持たせたい場合に有効である
        - 暗黙的に宣言された定数newValueは、()内に定数名を追加することで任意の名前を与えることができる
        - コンピューテッドプロパティでは、セッタの定義は任意
 
 [定義]
 var プロパティ名: 型名 {
    get {
        return文によって値を返す処理
    }
 
    set {
        値を更新する処理
        プロパティに代入された値には定数newValueとしてアクセスできる
    }
 }
 */

// ゲッター
struct Greeting4 {
    var to = "Rio Fujimon"
    // コンピューテッドプロパティ
    var body: String {
        // ゲッター
        get {
            return "Hello, \(to)!"
        }
    }
}

let greeting6 = Greeting4()
print(greeting6.body)

// celsiusとfahrenheitの一方を更新すれば、一方が更新される
struct Temperature {
    // 摂氏温度
    var celsius: Double = 0.0
    
    // 華氏温度
    var fahrenheit: Double {
        get {
            return (9.0/5.0) * celsius + 32.0
        }
        
        set {
            celsius = (5.0/9.0) * (newValue - 32.0)
        }
    }
}


var temperature = Temperature()
print(temperature.celsius)
print(temperature.fahrenheit)

temperature.celsius = 20
print(temperature.celsius)
print(temperature.fahrenheit)

temperature.fahrenheit = 32
print(temperature.celsius)
print(temperature.fahrenheit)


// セッタの省略
struct Greeting5 {
    var to = "Rio Fujimon"
    // セッタが存在しない場合は、getキーワードを省略できる
    var body: String {
        return "Hello, \(to)!"
    }
}

let greeting7 = Greeting5()
print(greeting7.body)


/*
 イニシャライザ：インスタンスの初期化処理

 全てのプロパティは、インスタンス化の完了までに値が代入されなければならないため、プロパティの宣言時に初期値を持たないプロパティは、イニシャライザで初期する必要がある
 
 
 [定義]
 init(引数) {
    // 初期化処理
 }
 
 失敗可能イニシャライザ：初期化の失敗を考慮したイニシャライザ
 イニシャライザは、全てのプロパティを正しい型の値で初期化する役割を果たしているが、イニシャライザの引数によっては、プロパティを初期化できないケースが出てくる
 初期化に失敗する可能性があるイニシャライザは失敗可能イニシャライザ（failable initializer）として表現でき、結果をOptional<Wrapped>型として返す
 失敗可能イニシャライザはinitキーワードに?を加えてinit?(引数)のように定義する
 初期化の失敗は、return nilで表す
 初期化を失敗させる場合にはインスタンス化が行われていないため、プロパティを未初期化のままにできる
 
 
 コンパイラによる初期化チェック
 プロパティの初期化はコンパイラによってチェックされ、一つでもプロパティが初期されないケースがある場合は、型の整合性が取れなくなってしまうためコンパイルエラーとなる
 */

// イニシャライザ
struct Greeting6 {
    let to: String
    var body: String {
        return "Hello, \(to)!"
    }
    
    // イニシャライザ
    init(to: String) {
        self.to = to
    }
}

let greeting8 = Greeting6(to: "Rio Fujimon")
let body = greeting8.body
print(body)

// 失敗可能イニシャライザ
struct Item {
    let id: Int
    let title: String
    
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int, let title = dictionary["title"] as? String else {
            // このケースでは、idとtitleは未初期化のままでもコンパイル可能
            return nil
        }
        
        self.id = id
        self.title = title
    }
}

let dictionaries: [[String:Any]] = [
    ["id": 1, "title": "abc"],
    ["id": 2, "title": "def"],
    ["title": "ghi"],
    ["id": 4, "title": "jkl"],
]

for dictionary in dictionaries {
    // 失敗可能イニシャライザはItem?を返す
    if let item = Item(dictionary: dictionary) {
        print(item)
    } else {
        print("エラー：辞書\(dictionary)からItemを生成できませんでした")
    }
}


/*
 // コンパイラによる初期化チェック
 struct Greeting {
    let to: String
    
    var body: String {
        return "Hello, \(to)!"
    }
 
    init(to: String) {
        // インスタンスの初期化後にtoが初期値を持たないのでコンパイルエラー
    }
 }
 */

/*
 struct Greeting {
    let to: String
    var body: String {
        return "Hello, \(to)!"
    }
 
    init(dictionary: [String: String]) {
        if let to = dictionary["to"] {
            self.to = to
        }
 
        // プロパティtoを初期化できないケースを定義していないのでコンパイルエラー
    }
 }
 */


// 失敗可能イニシャライザの使用
struct Greeting7 {
    let to: String
    var body: String {
        return "Hello, \(to)!"
    }
    
    init?(dictionary: [String: String]) {
        guard let to = dictionary["id"] else {
            return nil
        }
        
        self.to = to
    }
}

// デフォルト値の利用
struct Greeting8 {
    let to: String
    var body: String {
        return "Hello, \(to)!"
    }
    
    init(dictionary: [String: String]) {
        to = dictionary["id"] ?? "Rio Fujimon"
    }
}


/*
 メソッド：型に紐づいた関数
    - 型のインスタンスの振る舞いを実現するために使用される
 
 メソッド
    - インスタンスメソッド
    - スタティックメソッド
 
 
 インスタンスメソッド：型のインスタンスに紐づくメソッド
 
 スタティックメソッド：型自身に紐づくメソッド
    - スタティックメソッド：型自身に紐づくメソッドであり、インスタンスに依存しない処理
    - staticキーワードを追加する
 
 [定義]
 func メソッド名(引数) -> 戻り値の型 {
    メソッド呼び出し時に実行される文
 }
 
 [呼び出し]
 変数名.メソッド名(引数名1, 引数名2)
 */

// メソッド
struct Greeting9 {
    func greet(user: String) -> Void {
        print("Hello, \(user)")
    }
}

let greeting9 = Greeting9()
greeting9.greet(user: "Rio Fujimon")


// インスタンスメソッド
struct SomeStruct10 {
    var value = 0
    
    func printValue() {
        print("value: \(self.value)")
    }
}

var someStruct5 = SomeStruct10()
someStruct5.value = 1
someStruct5.printValue()

var someStruct6 = SomeStruct10()
someStruct6.value = 2
someStruct6.printValue()

struct Greeting10 {
    static var signature = "Sent from iPhone"
    
    static func setSignature(withDeviceName deviceName: String) {
        signature = "Sent from \(deviceName)"
    }
    
    var to = "Rio Fujimon"
    var body: String {
        return "Hello, \(to)!\n\(Greeting10.signature)"
    }
}

let greeting10 = Greeting10()
print(greeting10.body)
print("--")
Greeting10.setSignature(withDeviceName: "Xperia")
print(greeting10.body)


/*
 オーバーロード：型が異なる同名のメソッドの定義
 オーバーロードとは、異なる型の引数や戻り値を取る同名のメソッドを複数用意し、引数に渡される型や戻り値の代入先の型に応じて実行するメソッドを切り替える手法
 オーバーロードは、入出力の型が異なる似た処理に対して同名のメソッド群を用意し、呼び出し側にそれらの違いを意識させないという用途で使われる
 */

// オーバーロード
struct Printer {
    func put(_ value: String) {
        print("string: \(value)")
    }
    
    func put(_ value: Int) {
        print("int: \(value)")
    }
}

let printer = Printer()
printer.put("abc")
printer.put(123)

// 戻り値によるオーバーロード
struct ValueContainer {
    let stringValue = "abc"
    let intValue = 123
    
    func getValue() -> String {
        return stringValue
    }
    
    func getValue() -> Int {
        return intValue
    }
}

let valueContainer = ValueContainer()
let string: String = valueContainer.getValue()
let int: Int = valueContainer.getValue()
// 型アノテーションが省略されたのでコンパイルエラー
// bad: let value = ValueContainer.getValue()

/*
 サブスクリプト：コレクションの要素へのアクセス
    - 配列や辞書などコレクションの要素へのアクセスを統一的に表すための文法
    - ゲッタの定義は必須だが、セッタの定義は任意
    - セッタが存在しない場合、ゲッタのgetキーワードは省略可能
    - オーバーロード：型が異なるサブスクリプトの定義
 
 [定義]
 subscript(引数) -> 戻り値の型 {
    get {
        return文によって値を返す処理
    }
 
    set {
        値を更新する処理
    }
 }
 
 [使用方法]
 型のインスタンスが代入された変数や定数に[]で囲まれた引数を付けて変数名[引数]のように書く
 */

let array = [1, 2, 3]
let firstElement = array[0]
print(firstElement)

let dictionary = ["a": 1, "b": 2, "c": 3]
let elementForA = dictionary["a"]
print(elementForA)


// subscript
// 数列
struct Progression {
    var numbers: [Int]
    
    subscript(index: Int) -> Int {
        get {
            return numbers[index]
        }
        
        set {
            numbers[index] = newValue
        }
    }
}

var progression = Progression(numbers: [1, 2, 3])
let element1 = progression[1]
print(element1)

progression[1] = 4
let element2 = progression[1]
print(element2)


// 行列
struct Matrix {
    var rows: [[Int]]
    
    subscript(row: Int, column: Int) -> Int {
        get {
            return rows[row][column]
        }
        
        set {
            rows[row][column] = newValue
        }
    }
}

let matrix = Matrix(rows: [
    [1,2,3],
    [4,5,6],
    [7,8,9],
])

let element = matrix[1, 1]
print(element)


// subscriptのgetキーワードの省略
struct Progression2 {
    var numbers: [Int]
    
    subscript(index: Int) -> Int {
        return numbers[index]
    }
}

var progression2 = Progression(numbers: [1, 2, 3])
print(progression2[0])


// subscriptのオーバーロード
let array2 = [1, 2, 3, 4]
let element3 = array2[0]
let slice = array2[0...2]
print(element3) // Element
print(slice) // ArraySlice<Element>



/*
 エクステンション：型の拡張
    - Swiftでは、すでに存在している型に、プロパティやメソッドやイニシャライザなどの型を構成する要素を追加できる
    - エクステンションで追加したメソッドは、通常のメソッドと同様に使用できる
    - エクステンションでは、ストアドプロパティを追加することはできないが、コンピューテッドプロパティは追加できる
    - イニシャライザを追加することができる。既存の型にイニシャライザを追加することで、アプリケーション固有の情報から既存の型のインスタンスを生成するということも可能
 
 [定義]
 extension エクステンションを定義する対象の型 {
    // 対象の型に追加したい要素
 }
 */

extension String {
    func printSelf() {
        print(self)
    }
}

let string2 = "abc"
string2.printSelf()


// コンピューテッドプロパティの追加
extension String {
    var enclosedString: String {
        return "【\(self)】"
    }
}

let title = "重要".enclosedString + "今日は休み"
print(title)


// イニシャライザの追加

import UIKit

// アプリケーション固有のエラー
enum WebAPIError: Error {
    case connectionError(Error)
    case fatalError
    
    var title: String {
        switch self {
        case .connectionError:
            return "通信エラー"
        case .fatalError:
            return "致命的エラー"
        }
    }
    
    var message: String {
        switch self {
        case .connectionError(let underlyingError):
            return underlyingError.localizedDescription + "再試行してください"
        case .fatalError:
            return "サポート窓口に連絡してください"
        }
    }
}

extension UIAlertController {
    convenience init(webAPIError: WebAPIError) {
        // UIAlertControllerの指定イニシャライザ
        self.init(
            title: webAPIError.title,
            message: webAPIError.message,
            preferredStyle: .alert
        )
    }
}

let error = WebAPIError.fatalError
let alertController = UIAlertController(webAPIError: error)


/*
 型のネスト
    - Swiftでは、型の中に型を定義できる
        - (ex)
        - String.Index型
    - 型名をより明確かつ簡潔にできる
 */

// 型の名前から、NewsFeedItemKind型はNewsFeedItem型の種類を表していること推測できる
// これは、命名で縛っているに過ぎない
enum NewsFeedItemKind {
    case a
    case b
    case c
}

struct NewsFeedItem {
    let id: Int
    let title: String
    let type: NewsFeedItemKind
}

struct NewsFeedItem2 {
    enum Kind {
        case a
        case b
        case c
    }
    
    let id: Int
    let title: String
    let kind: Kind
    
    init(id: Int, title: String, kind: Kind) {
        self.id = id
        self.title = title
        self.kind = kind
    }
}

let kind = NewsFeedItem2.Kind.a
let item = NewsFeedItem2(id: 1, title: "Table", kind: kind)

switch item.kind {
case .a: print("kind is .a")
case .b: print("kind is .b")
case .c: print("kind is .c")
}
