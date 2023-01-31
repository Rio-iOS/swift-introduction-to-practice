//
//  TearDownTests.swift
//  
//
//  Created by 藤門莉生 on 2023/01/31.
//

import XCTest

class TearDownTests: XCTestCase {
    override class func tearDown() {
        super.tearDown()
        print("テストケース全体の事後処理")
    }
    
    override func tearDown() {
        super.tearDown()
        print("テストごとの事後処理")
    }
    
    func test1() {
        print("テスト1")
    }
    
    func test2() {
        print("テスト2")
    }
}
