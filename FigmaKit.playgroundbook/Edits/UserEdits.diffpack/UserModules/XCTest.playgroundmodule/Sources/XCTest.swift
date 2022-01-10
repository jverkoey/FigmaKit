public typealias XCTestCaseClosure = (XCTestCase) throws -> Void

open class XCTestCase {
    public required init(name: String, testClosure: @escaping XCTestCaseClosure) {
    }
}
