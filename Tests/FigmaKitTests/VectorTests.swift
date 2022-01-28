import FigmaKit
import Foundation
import XCTest

public final class VectorTests: XCTestCase {
    public func testDecoding() throws {
        let json = """
            {"x": 1, "y": 2}
            """.data(using: .utf8)!
        let decoder = JSONDecoder()
        let vector = try decoder.decode(Vector.self, from: json)
        
        XCTAssertEqual(vector.x, 1)
        XCTAssertEqual(vector.y, 2)
    }
}
