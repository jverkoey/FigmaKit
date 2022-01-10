open class XCTestCase {
    public init() {
        
    }
}

public func XCTestAssertTrue(_ value: Bool) {
    assert(value, "value expected to be true, was \(value) instead")
}
