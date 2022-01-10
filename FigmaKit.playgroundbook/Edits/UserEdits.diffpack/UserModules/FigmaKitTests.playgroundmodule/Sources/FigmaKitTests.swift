
import FigmaKit
import XCTest

public final class FigmaKitTests: XCTestCase {
    public override init() {
        super.init()
    }
    
    public static var allTests = {
        return [
            ("test_testTrue", testTrue),
        ]
    }()
    
    public func testTrue() {
        XCTestAssertTrue(false)
    }
}
