import FigmaKit
import Foundation
import XCTest

struct MyError: Error {
    
}

public final class RectangleTests: XCTestCase {
    public func testDecoding() throws {
        let json = """
            {"x": 1, "y": 2, "width": 3, "height": 4}
            """.data(using: .utf8)!
        let decoder = JSONDecoder()
        let rectangle = try decoder.decode(Rectangle.self, from: json)
        
        XCTAssertEqual(rectangle.x, 1)
        XCTAssertEqual(rectangle.y, 2)
        XCTAssertEqual(rectangle.width, 3)
        XCTAssertEqual(rectangle.height, 4)
    }
}
