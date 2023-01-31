//
//  File.swift
//  
//
//  Created by 藤門莉生 on 2023/01/31.
//

import XCTest
@testable import Demo

final class WaterBoilingPointTests: XCTestCase{
    
    func testWaterBoilingPoint() {
        let temperature = Temperature.waterBoilingPoint
        XCTAssertEqual(temperature.celsius, 100)
        XCTAssertEqual(temperature.fahrenheit, 212)
    }
}
