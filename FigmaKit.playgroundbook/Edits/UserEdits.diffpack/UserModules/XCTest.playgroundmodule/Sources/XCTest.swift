import AudioToolbox
import PlaygroundSupport

open class XCTestCase {
    public init() {
    }
}

public struct TestCase {
    let tests: [() throws -> ()]
    public init<T: XCTestCase>(_ instance: T, tests: (T.Type) -> [(T) -> () throws -> ()]) {
        self.tests = tests(T.self).map { $0(instance) }
    }
}

public func XCTestRun(testCases: [TestCase]) {
    var testsPassed = 0
    for testCase in testCases {
        for test in testCase.tests {
            do {
                prepareForTest()
                try test()
                if !didTestFail() {
                    testsPassed += 1
                }
            } catch let error {
                print(error)
            }
        }
    }
    
    let numberOfTests = testCases.reduce(0) { $0 + $1.tests.count }
    print("\(testsPassed) / \(numberOfTests) test passed.")
    
    if testsPassed < numberOfTests {
        PlaygroundPage.current.needsIndefiniteExecution = true
        AudioServicesPlaySystemSoundWithCompletion(1012) {
            PlaygroundPage.current.finishExecution()
        }
    }
}
