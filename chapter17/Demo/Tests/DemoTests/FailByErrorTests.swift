//
//  FailByErrorTests.swift
//  
//
//  Created by 藤門莉生 on 2023/01/31.
//

import XCTest
@testable import Demo

class FailByErrorTests: XCTestCase {
    
    func testThrows() throws {
        let int = try throwableIntFunction(throwsError: false)
        
        XCTAssert(0 < int)
    }
}
