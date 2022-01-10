
import FigmaKit
import XCTest

public final class FigmaKitTests: XCTestCase {
    public convenience init() {
        self.init(name: "") { _ in }
    }
    
    public func testTrue() {
        XCTAssertTrue(true)
    }
}
