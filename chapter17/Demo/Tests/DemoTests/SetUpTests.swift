//
//  SetUpTests.swift
//  
//
//  Created by 藤門莉生 on 2023/01/31.
//

import XCTest

class SomeTestCase: XCTestCase {
    // クラスメソッド
    override class func setUp() {
        super.setUp()
        print("テストケース全体の事前処理")
    }
   
    // インスタンスメソッド
    override func setUp() {
        super.setUp()
        print("テストごとの事前処理")
    }
    
    func test1() {
        print("テスト1")
    }
    
    func test2() {
        print("テスト2")
    }
}
