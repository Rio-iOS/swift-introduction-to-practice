//
//  StopOnFailureTests.swift
//  
//
//  Created by 藤門莉生 on 2023/01/31.
//

import XCTest

class StopOnFailureTests: XCTestCase {
    func testWithNil() {
        continueAfterFailure = false
        
        let optionalValue: Int! = nil
        // アサーションが失敗した時点で実行が中断される
        // XCTAssertNotNil(optionalValue)
        // XCTAssertEqual(optionalValue+7, 10) // 実行時エラーが発生しない
    }
}
