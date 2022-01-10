
import FigmaKit
import XCTest

public final class FigmaKitTests: XCTestCase {
    public required init(name: String, testClosure: @escaping XCTestCaseClosure) {
        super.init(name: name, testClosure: testClosure)
    }
    
    public static var allTests = {
        return [
            ("test_testTrue", testTrue),
        ]
    }()
    
    public func testTrue() {
        XCTAssertTrue(false)
    }
}
