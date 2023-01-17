import Foundation

/*
 Swiftの型
    - 構造体
    - クラス
    - 列挙型
 
 型の共通の仕様
    - プロパティ
    - メソッド
 */

/*
 型の種類を使い分ける目的
    - プログラミングでは、データを「型」として表現する
 
 大抵のデータ構造は、「構造体」や「クラス」で表現できるようになっている
 しかし、構造体、クラス、列挙型はそれぞれの目的に特快した機能や仕様を持っている為、
 データの特定に応じて適切な種類を選択すれば、単なる値と機能の組み合わせ以上の表現が可能になる
 */

/*
 値の受け渡し方法による分類
 
 Swiftの3つの型の種類は、値の受け渡しによって大別
    - 値型
    - 参照型
 
 値型と参照型の最大の違いは、変更を他の変数や定数と共有するかどうか
    - 値型：変更を共有しない型
        - 構造体
        - 列挙型
    - 参照型：変更を共有する型
        - クラス
 */

/*
 値型：値を表す型
 値型：インスタンスが値への参照ではなく、値そのものを表す型
    - 構造体
    - 列挙型
 
 変数や定数への値型のインスタンスの代入：インスタンスが表す値そのものの代入を意味する
    - 複数の変数や定数で1つの値型のインスタンスを共有することはできない
    - 一度代入したインスタンスは再代入を行わない限り不変であり、その値が予測可能になるというメリットがある
 
 値型のインスタンスが値そのものを表すという仕様
    - 変数、定数への代入や関数への受け渡しのたびにコピーを行い、もとのインスタンスが表す値を不変にすることによって実現されている
 
 mutatingキーワード：自身の値の変更を宣言するキーワード
 値型：mutatingキーワードをメソッドの宣言時に追加することで、自身の値を変更する処理を実行できる
    - mutatingキーワードが指定されたメソッドを実行してインスタンスの値を変更すると、インスタンスが格納されている変数への暗黙的な再代入が行われる
    - mutating期キーワードが指定されたメソッドの呼び出しは再代入として扱われる為、定数に細田隠喩された値型のインスタンスに対しては実行できず、コンパイルエラーとなる
    - 定数に対して実行できないという仕様は、インスタンスが保持する値の変更を防ぎたい場合に役立つ
 
 [定義]
 mutating func メソッド名(引数) -> 戻り値の型 {
    // メソッド呼び出し時に実行される文
 }
 */

// 値型（Int型, Float型）
var a = 4.0
var b = a // bに4.0が入る（aが持つ4.0への参照ではなく値である4.0が入る）
a.formSquareRoot() // aの平方根を取る
print(a)
print(b)


struct Color {
    var red: Int
    var green: Int
    var blue: Int
}

var a2 = Color(red: 255, green: 0, blue: 0)
var b2 = a2
a2.red = 0 // aを黒に変更する

print(a2.red)
print(a2.green)
print(a2.blue)

// b2は赤のまま
print(b2.red)
print(b2.green)
print(b2.blue)


// mutatingキーワード
extension Int {
    mutating func increment() {
        self += 1
    }
}

var a3 = 1
a3.increment()
print(a3)


var mutableArray = [1, 2, 3]
mutableArray.append(4) // [1, 2, 3, 4]

let immutableArray = [1, 2, 3]
// bad: immutableArray.append(4)


/*
 参照型：値への参照を表す型
 参照型：インスタンスが値への参照を表す型
    - SwiftにおけるClass
    - 変数や定数への参照型の値の代入は、インスタンスに対する参照の代入を意味する為、複数の変数や定数で1つの参照型のインスタンスを共有できる
    - 変数や定数への代入時や関数への受け渡し時にはインスタンスのコピーが発生しないため、効率的なインスタンスの受け渡しができるというメリットがある
 
 値の変更の共有
 値型では、変数や定数は他の値の変更による影響を受けないことが保証されていた
 参照型では、1つのインスタンスが複数の変数や定数の間で共有される為、ある値に対する変更はインスタンスを共有している他の変数や定数にも伝播する
 */

class IntBox {
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
}

var a4 = IntBox(value: 1) // aはIntBox(value: 1)を参照する
var b4 = a4 // bはaと同じインスタンスを参照する

print(a4.value)
print(b4.value)

// a4.valueを2に変更する
a4.value = 2
print(a4.value)
print(b4.value)


/*
 値型と参照型の使い分け
 値型は、変数や定数への代入や引数への受け渡しのたびにコピーされ、変更や共有されない。
 したがって、一度代入された値は、明示的に再代入しない限りは不変であることが保証される。
 一方の参照型はその逆であり、変数や定数への代入や引数への受け渡しの際にコピーされずに参照が渡されるため、変更が共有される。
 したがって、一度代入された値が変更されないことの保証は難しくなる。
 
 -> 安全にデータを取り扱うためには、積極的に値型を使用し、参照型は状態管理などの変更の共有が必要となる範囲にとどめるのが良い
 */

/*
 構造体：値型のデータ構造
 構造体：値型の一種であり、ストアドプロパティの組み合わせによって1つの値を表す
    - 標準ライブラリで提供されている多くの型は構造体
    - 構造体ではないのは、列挙型であるOptional<Wrapped>型、型の組み合わせであるタプル型、プロトコルであるAny型のみ
 
 [定義]
 struct 構造体名 {
    // 構造体の定義
 }
 */

// 構造体の定義
struct Article {
    let id: Int
    let title: String
    let body: String
    
    init(id: Int, title: String, body: String) {
        self.id = id
        self.title = title
        self.body = body
    }
    
    func printBody() {
        print(body)
    }
}

let article = Article(id: 1, title: "title", body: "body")
article.printBody()

/*
 ストアドプロパティの変更による値の変更
 構造体は、ストアドプロパティの組み合わせで1つの値を表す値型である。
 構造体のストアドプロパティを変更することは、構造体を別の値に変更することであり、
 構造体が入っている変数や定数への再代入を必要とする。
 
 値型の値の変更に関する仕様は、構造体のストアドプロパティの変更にも適用される
 
 
 定数のストアドプロパティは変更できない
 構造体のストアドプロパティの変更は再代入を必要とするため、定数に代入された構造体のストアどプロパティは変更できない
 */

struct SomeStruct {
    var id: Int
    
    init(id: Int) {
        self.id = id
    }
}

var variable = SomeStruct(id: 1)
variable.id = 2
print(variable.id)

let constant = SomeStruct(id: 1)
// bad: constant.id = 2


/*
 メソッド内のストアドプロパティの変更にはmutatingキーワードが必要
 */

struct SomeStruct2 {
    var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    mutating func someMethod() {
        id = 4
    }
}

var a5 = SomeStruct2(id: 1)
a5.someMethod()
print(a5.id)

/*
 // mutatingキーワードがないとコンパイルエラー
 struct SomeStruct2 {
     var id: Int
     
     init(id: Int) {
         self.id = id
     }
     
     func someMethod() {
         id = 4
     }
 }
 */

/*
 メンバーワイズイニシャライザ：デフォルトで用意されているイニシャライザ
 
 型のインスタンスは初期化後に全てのプロパティが初期化されている必要がある
 独自にイニシャライザを定義して初期化の処理を行うこともできるが、構造体では自動的に定義される
 メンバーワイズイニシャライザ（memberwise initializer）というイニシャライザが利用できる
 
 メンバーワイズイニシャライザ：型が持っている各ストアドプロパティと同名の引数をとるイニシャライザ
 */

// メンバーワイズイニシャライザ
struct Article2 {
    var id: Int
    var title: String
    var body: String
}

let article2 = Article2(id: 1, title: "Hello", body: "...")
print(article2.id)
print(article2.title)
print(article2.body)

/*
 メンバーワイズイニシャライザのデフォルト引数
 ストアドプロパティが初期化式とともに定義されている場合、そのプロパティに対応するメンバーワイズイニシャライザの引数はデフォルト引数を持ち、呼び出し時の引数を省略できる
 */

struct Mail {
    var subject: String = "(No Subject)"
    var body: String
}

let noSubject = Mail(body: "Hello!")
print(noSubject.subject)
print(noSubject.body)

let greeting = Mail(subject: "Greeting", body: "Hello")
print(greeting.subject)
print(greeting.body)


/*
 クラス：参照型のデータ構造
 
 構造体との大きな違い
    - 一つは参照型であること
    - 継承が可能であること
 
 [定義]
 class クラス名 {
    // クラスの定義
 }
 */

class SomeClass {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    func printName() {
        print(name)
    }
}

let instance = SomeClass(id: 1, name: "name")
instance.printName()

/*
 継承：型の構成要素の引き継ぎ
 継承：新たなクラスを定義するときに、他のクラスのプロパティ、メソッド、イニシャライザなどの型を再利用する仕組み
 継承先のクラスでは、継承元のクラスと共通する動作をあらためて定義する必要がなく、継承元のクラスとの差分のみを定義すれば済む
 
 サブクラス：継承先のクラス
 スーパークラス：継承元のクラス
 
 Swiftでは、複数のクラスから継承する多重継承は禁止されている
 
 [定義]
 class クラス名: スーパークラス名 {
    // クラスの定義
 }
 */

class User {
    let id: Int
    
    var message: String {
        return "Hello."
    }
    
    init(id: Int) {
        self.id = id
    }
    
    func printPforile() {
        print("id: \(id)")
        print("message: \(message)")
    }
}

// Userを継承したクラス
class RegisteredUser: User {
    let name: String
    
    init(id: Int, name: String) {
        self.name = name
        super.init(id: id)
    }
}

let registeredUser = RegisteredUser(id: 1, name: "Rio Fujimon")
let id = registeredUser.id
let message = registeredUser.message
registeredUser.printPforile()

/*
 オーバーライド：型の構成要素の再定義
 オーバーライド：スーパークラスで定義されているプロパティやメソッドなどの要素は、サブクラスで再定義することもできる
 オーバーライド可能なプロパティは、インスタンスプロパティとクラスプロパティのみで、スタティックプロパティはオーバーライドできない
 
 オーバーライドを行うには、overrideキーワードを使用してスーパークラスで定義されている要素を再定義
 
 [定義]
 class クラス名: スーパークラス名 {
    override func メソッド名(引数) -> 戻り値の型 {
        // メソッド呼び出し時に実行される文
    }
 
    override var プロパティ名: 型名 {
        get {
            return文によって値を返す処理
            superキーワードでスーパークラスの実装を利用できる
        }
 
        set {
            値を更新する処理
            superキーワードでスーパークラスの実装を利用できる
        }
    }
 }
 */


class User2 {
    let id: Int
    
    var message: String {
        return "Hello."
    }
    
    init(id: Int) {
        self.id = id
    }
    
    func printProfile() {
        print("id: \(id)")
        print("message: \(message)")
    }
}


class RegisteredUser2: User {
    let name: String
    
    override var message: String {
        return "Hello, my name is \(name)"
    }
    
    init(id: Int, name: String) {
        self.name = name
        super.init(id: id)
    }
    
    override func printPforile() {
        super.printPforile()
        print("name: \(name)")
    }
}

let user = User2(id: 1)
user.printProfile()

print("--")

let registeredUser2 = RegisteredUser2(id: 2, name: "Rio Fujimon")
registeredUser2.printPforile()


/*
 finalキーワード：継承とオーバーライドの禁止
 オーバーライド可能な要素の前にfinalキーワードを記述することで、その要素がサブクラスでオーバーライドされることを禁止できる
 */

class SuperClass {
    func overridableMethod() {}
    
    final func finalMethod() {}
}

class SubClass: SuperClass {
    override func overridableMethod() {}
    
    // オーバーライド不可能なためコンパイルエラー
    // bad: override func finalMethod(){}
}

class InheritableClass {}

class ValidSubClass: InheritableClass {}

final class FinalClass {}

// 継承不可能なためコンパイルエラー
// class InvalidSubClass: FinalClass {}

