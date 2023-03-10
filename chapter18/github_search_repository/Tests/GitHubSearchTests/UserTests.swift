//
//  File.swift
//  
//
//  Created by 藤門莉生 on 2023/02/01.
//

import Foundation
import XCTest
import GitHubSearch

class UserTests: XCTestCase {
    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        let data = User.exampleJSON.data(using: .utf8)!
        let user = try jsonDecoder.decode(User.self, from: data)
        XCTAssertEqual(user.id, 10639145)
        XCTAssertEqual(user.login, "apple")
    }
}
