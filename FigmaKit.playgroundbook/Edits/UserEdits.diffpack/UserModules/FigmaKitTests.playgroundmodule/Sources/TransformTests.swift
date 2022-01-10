import FigmaKit
import Foundation
import XCTest

public final class TransformTests: XCTestCase {
    public func testDecoding() throws {
        let json = """
            [[0,1,2], [3,4,5]]
            """.data(using: .utf8)!
        let decoder = JSONDecoder()
        let transform = try decoder.decode(Transform.self, from: json)
        
        XCTAssertEqual(transform.row1, [0, 1, 2])
        XCTAssertEqual(transform.row2, [3, 4, 5])
    }
}
