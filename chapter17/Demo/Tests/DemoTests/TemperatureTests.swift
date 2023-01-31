import XCTest
import Demo

/*
 プログラムを変更したとしても、テストが成功する限りは、Temperature型の動作は保証されている
 */
final class TemperatureTests: XCTestCase {
    func testWaterMeltingPoint() {
        let temperature = Temperature(celsius: 0)
        XCTAssertEqual(temperature.celsius, 0)
        XCTAssertEqual(temperature.fahrenheit, 32)
    }
    
    func testWaterBoilingPoint() {
        let temperature = Temperature(celsius: 100)
        XCTAssertEqual(temperature.celsius, 100)
        XCTAssertEqual(temperature.fahrenheit, 212)
    }
}
