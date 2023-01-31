//
//  File.swift
//  
//
//  Created by 藤門莉生 on 2023/01/31.
//

import XCTest

class SomeTestCaseTests: XCTestCase {
    func testWithNil() {
        let optionalValue: Int! = nil
        XCTAssertNotNil(optionalValue)
        XCTAssertEqual(optionalValue+7, 10)
    }
}
