import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(swift_sdl2_openglTests.allTests),
    ]
}
#endif
