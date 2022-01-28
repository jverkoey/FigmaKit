import FigmaKit
import Foundation
import XCTest

public final class PathTests: XCTestCase {
    public func testDecoding() throws {
        let json = """
            {"path":"M0 0L10 0L10 10L0 10L0 0Z","windingRule":"NONZERO"}
            """.data(using: .utf8)!
        let decoder = JSONDecoder()
        let path = try decoder.decode(Path.self, from: json)
        
        XCTAssertEqual(path.path, "M0 0L10 0L10 10L0 10L0 0Z")
        XCTAssertEqual(path.windingRule, .nonZero)
    }
}
