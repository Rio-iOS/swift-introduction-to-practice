//
//  File.swift
//  
//
//  Created by 藤門莉生 on 2023/01/31.
//

import XCTest
@testable import Demo

final class ErrorAssertionTests: XCTestCase {
    func test() {
        XCTAssertThrowsError(try throwableFunction(throwsError: true))
        XCTAssertNoThrow(try throwableFunction(throwsError: false))
    }
}
