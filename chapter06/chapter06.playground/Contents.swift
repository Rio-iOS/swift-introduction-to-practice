import Foundation

/*
 関数とクロージャ：処理を1つにまとめて外部から実行可能にするもの
    - 関数はクロージャの一種
 
 関数やクロージャ：ひとまとまりの処理を切り出し、再利用可能とするためのもの
 再利用できそうな処理を適切に関数やクロージャにすることで、重複した処理を1ヶ所にまとめ、可読性やメンテナンス性を高めることができる
 */

/*
 関数：名前を持ったひとまとまりの処理
 関数は、入力として引数、出力として戻り値をもつ、名前を持ったひとまとまりの処理である
 関数の名前のことを関数名
 関数名と引数を組み合わせることで、関数を外部から呼び出すことができる
 戻り値を返すには、{}内でreturn文を使用する
 return文：プログラムの制御を関数の呼び出し元に移す文
    - returnキーワードに続けて戻り値となる式をreturn 式と記述する
    - 式の型はコンパイル時に検証され、戻り値の型と異なる場合はコンパイルエラーとなる
    - 戻り値がない関数では、return文の式を指定せずにreturnキーワードのみを記述
    - 戻り値がない関数ではreturnキーワードを省略することもできる
 
 関数は、関数名に「()」を付け、()内に関数の入力となる引数とその引数名を「,」区切りで記述して実行
 
 関数は実行後に、出力となる戻り値を返す
 戻り値は変数や定数に代入できる
 
 Playgroung以外の環境では、戻り値の代入を省略するとコンパイラが警告を出す
 
 戻り値が不要な場合は「_」への代入によって明示的に戻り値を無視することで、この警告を抑制できる
 もしくは、戻り値の使用が必須でない関数にdiscardableResult属性を付与することでも、この警告を抑制できる
 
 引数：関数への入力
 引数は名前と型で構成されており、関数は複数の引数を持つことができる
 
 関数の引数
    - 仮引数：関数の定義時に宣言するものを指す場合
    - 実引数：関数の呼び出し時に指定するものを指す場合
 
 外部引数名と内部引数名
 引数名
    - 関数の呼び出し時に使用する外部引数名
    - 関数内部で使用される内部引数名
 外部引数には、関数を利用する側から見てわかりやすい名前を、内部引数にはプログラムが冗長にならない名前をつける
 
 
 外部引数名の省略
 外部引数名を省略したい場合には、外部引数に「_」を使用する
 外部引数名が「_」で省略されている場合は、引数名と引数を分けている「:」も省略して呼び出す
 
 
 デフォルト引数：引数のデフォルト値
 引数には、デフォルト値を指定でき、デフォルト値を持っている引数は関数呼び出し時に省略できる
 デフォルト引数：引数のデフォルト値
 通常の引数宣言の後に「=」とデフォルト値を追加する
 デフォルト引数はどのような引数にも定義でき、複数の引数に定義することもできる
 デフォルト引数は、検索条件のような数多くの引数が必要なものの、全ての引数の指定が必須ではない関数を定義する場合に役立つ
 
 
 インアウト引数：関数外に変更を共有する引数
 関数内での引数への再代入を関数外へ反映させるには、インアウト引数（inout parameters）を使用する
 インアウト引数を使用するには、引数の型の先頭にinoutキーワードを追加する
 インアウト引数を持つ関数を呼び出すには、インアウト引数の先頭に「&」を加える
 
 
 可変長引数：任意の個数の値を受け取る引数
 可変長引数：任意の個数の値を受け取ることができる引数のこと
 配列を引数に取ることでも複数の値を受け取ることができるが、可変長引数には関数の呼び出し側に配列であることを意識させないというメリットがある
 Swiftでは、1つの関数につき最大1つの可変長引数を定義できる
 可変長引数を定義するには、引数定義の末尾に「...」を加える
 可変長引数をもつ関数を呼び出すには、引数を「,」区切りで渡す
 可変長引数として受け取った引数は、関数内部では、Array<Element>として扱われる
 
 
 コンパイラによる引数チェック
 実引数の型もコンパイル時にチェックされ、異なる型の実引数を与えるプログラムはコンパイルエラーとなる
 
 
 戻り値：関数の出力を表す値
 戻り値の型は、関数宣言時に定義し、関数の呼び出し側は定義された戻り値の型の値を出力として受け取る

 
 戻り値がない関数
 関数宣言での戻り値の型の指定は必須ではない
 戻り値が不要な場合は、関数宣言での戻り値の型の定義を省略できる
 
 
 コンパイラによる戻り値のチェック
 関数宣言で定義されている戻り値の型と実際の戻り値の型が一致するかどうかは、コンパイラによってチェックされる
 定義された戻り値の型と一致しない型を返すプログラムはコンパイルエラーとなり、戻り値が定義通りの値を返すことはコンパイル時に保証される
 
 
 暗黙的なreturn
 暗黙的なreturn（implicit returns）：関数の実装が戻り値の返却のみで構成される場合、returnキーワードど省略できる
 関数の実装が戻り値の返却以外にも含まれている場合、コンパイルエラーとなる
 
 
 [記述方法]
 func 関数名(引数名1: 型, 引数名2: 型, ...) -> 戻り値の型 {
    関数呼び出し時に実行される文
    必要に応じてreturn文で戻り値を返却
 }
 
 let 定数名 = 関数名(引数名1: 引数1, 引数名2: 引数2, ...)
 */

func double(_ x: Int) -> Int {
    return x * 2
}

print(double(2))

func functionWithDiscardableResult() -> String {
    return "Discardable"
}

print(functionWithDiscardableResult())

// discardableResult属性の付与
@discardableResult
func functionWithDiscardableResult2() -> String {
    return "Discadable"
}

_ = functionWithDiscardableResult2()

// 仮引数と実引数
// int：仮引数
func printInt(_ int: Int) {
    print(int)
}

// 1：実引数
printInt(1)

// 外部引数名と内部引数名
// 外部引数：to
// 内部引数：group
func invite(user: String, to group: String) {
    print("\(user) is invited to \(group).")
}

invite(user: "fujimon", to: "takahashi")

// 外部引数名の省略
func sum(_ int1: Int, _ int2: Int) -> Int {
    return int1 + int2
}

let result = sum(1, 2)
printInt(result)

// デフォルト引数
func greet(user: String = "Rio Fujimon") {
    print("Hello, \(user)")
}

greet()

// デフォルト引数の複数指定
func search(
    byQuery query: String,
    sortKey: String = "id",
    ascending: Bool = false
) -> [Int] {
    return [1, 2, 3]
}

print(search(byQuery: "query"))


// インアウト引数（inout parameters）
// inoutキーワードの指定
func greet2(user: inout String) {
    if user.isEmpty {
        user = "Anonymous"
    }
    
    print("Hello, \(user)")
}

var user: String = ""
// 「&」を記述
greet2(user: &user)


// 可変長引数
// 呼び出し元に、引数が配列だと意識させないというメリットがある
func print(strings: String...) {
    if strings.count == 0 {
        return
    }
    
    print("first: \(strings[0])")
    
    for string in strings {
        print("element: \(string)")
    }
}

print(strings: "abc", "def", "ghi")


// コンパイラによるチェック
func string(from: Int) -> String {
    return "\(from)"
}
let int = 1

let double = 1.0

print(string(from: int))
// bad: print(string(double))


// 戻り値のない関数
func greet3(user: String) {
    print("Hello, \(user)")
}

greet3(user: "Fujimon")

func greet4(user: String) -> Void {
    print("Hello, \(user)")
}

greet4(user: "Fujimon")

// コンパイラによる戻り値のチェック

/*
 // bad
 func convertToInt(from string: String) -> Int {
 // Int(_:)はInt?型を返すためコンパイルエラー
 // String -> Intは、成功するとは限らない
 return Int(string)
 }
*/

// 暗黙的なreturn
func makeMessage(toUser user: String) -> String {
    "Hello, \(user)"
}

print(makeMessage(toUser: "Rio Fujimon"))

/*
// bad
func makeMessage2(toUser user: String) -> String {
 // 戻り値以外にも実装を含む
 print(user)
 "Hello, \(user)!"
}
*/


/*
 クロージャ：スコープ内の変数や定数を保持したひとまとまりの処理
 クロージャ：再利用可能なひとまとまりの処理
 関数はクロージャの一種であるため、共通の仕様が数多くある
 クロージャ式は、名前が不要であったり、型推論によって型の記述が省略可能である
 クロージャの型は、通常の型と同じように扱えるので、変数や定数の型や関数の引数の型として利用することもできる

 
 型推論
 クロージャの引数と戻り値の型宣言は、クロージャの代入先の型から推論することによって省略できるケースがある
 型が決まっていない変数や定数へのクロージャを代入する場合など、クロージャの型から推論できないケースでは、クロージャ内で引数と戻り値の型を定義しなければならない
 
 
 実行方法
 呼び出し方は関数と同じで、クロージャが代入されている変数名や定数名の末尾に「()」を付け、()内に引数を「,」区切りで並べる

 
 関数とクロージャの機能の比較
 利用可能な機能 | 関数 | クロージャ式
 外部引数名 | ○ | ×
 デフォルト引数 | ○ | ×
 インアウト引数 | ○ | ○
 可変長引数 | ○ | ○
 簡略引数名 | × | ○
 

 簡略引数名：引数名の省略
 定義するクロージャの型が推論できるケースでは、型を省略できる
 このようなケースでは、引数名の定義を省略し、代わりに簡略引数名（shorthand argument name）を利用できる
 簡略引数名は、「$」に引数のインデックスを付けた$0や$1となる
 簡略引数をむやみやたらに使用すると、引数が何を意味しているかわからない可読性の低いコードになりがちだが、
 非常にシンプルな処理を行う場合は積極的に利用するべきである
 
 
 戻り値
 戻り値がないクロージャを定義することができる
 通常、クロージャの型の表記においては、引数が存在しない場合は()を使用し、戻り値がない場合はVoid型を使用する
    - ()->Void
 
 
 クロージャによる変数と定数のキャプチャ
 ローカルスコープで定義された変数や定数は、ローカルスコープ内でしか使用できない
 キャプチャ：クロージャが参照している変数や定数は、クロージャが実行されるスコープが変数や定数が定義されたローカルスコープ以外であっても、クロージャの実行時に利用できる
 これは、クロージャが自身が定義されたスコープの変数や定数への参照を保持しているため
 キャプチャの対象は、変数や定数に入っている値ではなく、その変数や定数自身である。
 従って、キャプチャされている変数への変更は、クロージャの実行時にも反映される
 
 通常、doキーワードはcatchキーワードと組み合わせてエラー処理で使用するが、新しいスコープを作成するという用途で単独で使用することができる
 
 
 引数としてのクロージャ
 クロージャを関数や別のクロージャの引数として利用する場合にのみ有効な仕様として、属性とトレイリングクロージャがある
 属性：クロージャに対して指定する追加情報
 トレイリングクロージャ：クロージャを引数に取る関数の可読性を高める仕様

 
 escaping属性：非同期的に実行されるクロージャ
 escaping属性：関数に引数として渡されたクロージャが関数のスコープ外で保持される可能性があることを示す属性
 コンパイラはescaping属性の有無によって、クロージャがキャプチャを行う必要があるかを判別する
 クロージャが関数のスコープ外で保持されなければ、クロージャの実行は関数の実行中に限られるため、キャプチャは必要ない
 クロージャが関数のスコープ外で保持される可能性がある場合、つまりescaping属性が必要な場合は、クロージャの実行時まで関数のスコープの変数を保持する必要があるため、キャプチャが必要となる
 escaping属性が指定されていないクロージャは、関数のスコープ外では保持できない
 従って、クロージャの実行は関数のスコープ内で行われなければならない
 
 
 autoclosure属性：クロージャを用いた遅延評価
 autoclosure属性：引数をクロージャで包むことで遅延評価を実現するための属性
 
 
 トレイリングクロージャ：引数のクロージャを()の外に記述する記法
 トレイリングクロージャ（trailing closure）：関数の最後の引数がクロージャの場合に、クロージャを()の外に書くことができる
 通常の記法では、関数呼び出しの()がクロージャの後まで広がってしまい、特にクロージャが複数行にまたがる場合に、その可読性の低さは顕著となる
 一方、トレイリングクロージャを使用した場合には()はクロージャの定義の前で閉じるため、少しだけコードが読みやすくなる
 
 
 クロージャとしての関数
 関数はクロージャの一種であるため、クロージャとして扱える
 関数をクロージャとして利用するには、関数名だけの式で関数を参照する
 関数をクロージャとして扱うことで、関数を変数や定数に代入したり、別の関数の引数に渡したりできる
 関数の引数となるクロージャを関数として定義しておくことで、重複したクロージャを1つにまとめたり、クロージャに対して意味のある名前をつけたりすることができる
 
 
 クロージャを利用した変数や定数の初期化
 クロージャ式を利用すると、複雑な値の初期化を把握しやすくなる
 
 
 [定義方法]
 {(引数名1: 型, 引数名2: 型, ...) -> 戻り値の型 in
    クロージャの実行時に実行される文
    必要に応じてreturn文で戻り値を返却する
 }
 
 let 定数名 = 変数名(引数1, 引数2, ...)
 
 [属性の指定方法]
 func 関数名(引数名: @属性名 クロージャの型名) {
    関数呼び出し時に実行される文
 }
 
 [クロージャとしての関数の定義]
 let 定数名 = 関数名(引数名1, 引数名2, ...)
 */

// クロージャ
let double2 = {(x: Int) -> Int in
    return x * 2
}

print(double2(2))

// クロージャの型は、変数や定数、関数の型名として使える
let closure: (Int) -> Int
func someFunction(x: (Int) -> Int) {}


// クロージャの引数と戻り値の型の省略

var closure2: (String) -> Int

// 引数と戻り値の型を明示した場合
closure2 = { (string: String) -> Int in
    return string.count
}
print(closure2("abc"))

// 引数と戻り値の型を省略した場合
closure2 = { string in
    return string.count * 2
}
print(closure2("abc"))


/*
 // クロージャの型が決定しないためコンパイルエラー
 let closure = { string in
    return string.count * 2
 }
 */

// クロージャの実行
let lengthOfString = {(string: String) -> Int in
    return string.count
}
print(lengthOfString("I contain 23 characters"))


let add = { (x: Int, y: Int) -> Int in
    return x + y
}
print(add(1, 2))

/*
 // クロージャの引数にはデフォルト引数を指定できない
 let greet = {(user: String = "Anonymous") -> Void in
    print("Hello, \(user)")
 }
 */

// 簡略引数の利用
let isEqual: (Int, Int) -> Bool = {
    return $0 == $1
}
print(isEqual(1, 1))

/*
 // isEqualの型が定まらないためコンパイルエラー
 let isEqual = {
    return $0 == $1
 }
 */

let numbers = [10, 20, 30, 40]
// シンプルな処理の場合は、積極的に簡易引数を利用するべき
let moreThanTwenty = numbers.filter { 20 < $0 }
print(moreThanTwenty)

// 戻り値がないクロージャ
let emptyReturnValueClosure: () -> Void = {}

// 1つの戻り値を持つクロージャ
let singleReturnValueClosure: () -> Int = {
    return 1
}


// クロージャによるキャプチャ
let greeting: (String) -> String

do {
    let symbol = "!"
    // クロージャがキャプチャによって、自分自身が定義されたスコープの変数や定数への参照を保持する
    greeting = { user in
        return "Hello, \(user)\(symbol)"
    }
}

// greeting()が、symbolを参照しているため、do{}でもsymbolが使える
print(greeting("Fujimon"))

// bad: print(symbol)

let counter: () -> Int

do {
    var count = 0
    counter = {
        count += 1
        return count
    }
}

print(counter())
print(counter())


func or(_ lhs: Bool, _ rhs: @autoclosure () -> Bool) -> Bool {
    if lhs {
        return true
    } else {
        return rhs()
    }
}

or(true, false)


// escaping属性
var queue = [()->Void]()

func enqueue(operation: @escaping () -> Void) {
    queue.append(operation)
}

enqueue {print("executed")}
enqueue {print("executed")}

queue.forEach { $0() }

// escaping属性をつけない場合
func executeTwice(operation: () -> Void) {
    operation()
    operation()
}

executeTwice {
    print("executed")
}


func or2(_ lhs: Bool, _ rhs: Bool) -> Bool {
    if lhs {
        print("true")
        return true
    } else {
        print("rhs")
        return rhs
    }
}
or2(true, false)


// lhs()とrhs()の両方が、or3()に渡された時点で実行されてしまう
// 正格評価が行われてしまう
func or3(_ lhs: Bool, _ rhs: Bool) -> Bool {
    if lhs {
        print("true")
        return true
    } else {
        print("rhs")
        return rhs
    }
}

func lhs() -> Bool {
    print("lhs()関数が実行される")
    return true
}

func rhs() -> Bool {
    print("rhs()関数が実行される")
    return false
}

or3(lhs(), rhs())

// rhs()は、実行されない
// 第2引数をクロージャにすることによって、必要になるまで評価を遅らせることができるようになる
// 遅延評価
// コードは無駄な関数の実行を回避できるというメリットがある一方で、呼び出し側が煩雑になってしまうデメリットもある
// ここでメリットを享受しつつ、デメリットを回避するための属性がautoclosure属性
// autoclosure属性：引数をクロージャで包むという処理を暗黙的に行う
func or4(_ lhs: Bool, _ rhs: () -> Bool) -> Bool {
    if lhs {
        print("true")
        return true
    } else {
        let rhs = rhs()
        print(rhs)
        return rhs
    }
}

func lhs2() -> Bool {
    print("lhs2()関数が実行される")
    return true
}

func rhs2() -> Bool {
    print("rhs2()関数が実行される")
    return false
}

// autoclosure属性が指定されていないため、{ return rhs2() }で渡す必要がある
or4(lhs2(), { return rhs2() })

// autoclosure属性を追加
func or5(_ lhs: Bool, _ rhs: @autoclosure () -> Bool) -> Bool {
    if lhs {
        print("true")
        return true
    } else {
        let rhs = rhs()
        print(rhs)
        return rhs
    }
}

func lhs3() -> Bool {
    print("lhs3()関数が実行される")
    return true
}

func rhs3() -> Bool {
    print("rhs3()関数が実行される")
    return false
}
// autoclosure属性が指定されているため、rhs3()でOK
or5(lhs3(), rhs3())


// トレイリングクロージャ

func execute(parameter: Int, handler: (String) -> Void) {
    handler("parameter is \(parameter)")
}

// トレイリングクロージャを使用しない場合
execute(parameter: 1, handler: {string in
    print(string)
})

// トレイリングクロージャを使用する場合
execute(parameter: 2) { string in
    print(string)
}

func execute2(handler: (String) -> Void) {
    handler("executed.")
}

execute2 { string in
    print(string)
}

// クロージャとしての関数
func double3(_ x: Int) -> Int {
    return x * 2
}

let function = double3

let array1 = [1, 2, 3]
let doubledArray1 = array1.map { $0 * 2}
print(doubledArray1)

let array2 = [4, 5, 6]
let doubledArray2 = array2.map{ $0 * 2 }
print(doubledArray2)

// クロージャとしての関数
// 重複していた{ $0 * 2 }をまとめることができ、それに対してdoubleという名前を与えることで可読性が上がった
func double4(_ x: Int) -> Int {
    return x * 2
}

let array3 = [1, 2, 3]
let doubledArray3 = array3.map(double4)

let array4 = [4, 5, 6]
let doubledArray4 = array4.map(double4)


// クロージャを利用した変数や定数の初期化
var board = [[1, 1, 1], [1, 1, 1], [1, 1, 1]]
print(board)

// 2次元配列を生成する手続きによる記述
// 構造の把握が難しい
var board2 = Array(repeating: Array(repeating: 1, count: 3), count: 3)
print(board2)


// クロージャの利用
//　変数や定数の初期化処理が複雑であっても、その初期値がどのように生成されるのか把握しやすい
var board3: [[Int]] = {
    let sideLength = 3
    let row = Array(repeating: 1, count: 3)
    let board = Array(repeating: row, count: 3)
    return board
}()
print(board3)
