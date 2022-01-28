import FigmaKit
import Foundation
import XCTest

public final class ColorTests: XCTestCase {
    public func testDecoding() throws {
        let json = """
            {"r": 0, "g": 0.25, "b": 0.5, "a": 0.75}
            """.data(using: .utf8)!
        let decoder = JSONDecoder()
        let color = try decoder.decode(Color.self, from: json)
        
        XCTAssertEqual(color.r, 0)
        XCTAssertEqual(color.g, 0.25)
        XCTAssertEqual(color.b, 0.5)
        XCTAssertEqual(color.a, 0.75)
    }
}
