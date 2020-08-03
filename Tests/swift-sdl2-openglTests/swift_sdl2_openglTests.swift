    import XCTest
    @testable import swift_sdl2_opengl

    final class swift_sdl2_openglTests: XCTestCase {
        func testExample() {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct
            // results.
            XCTAssertEqual(swift_sdl2_opengl().text, "Hello, World!")
        }

        static var allTests = [
            ("testExample", testExample),
        ]
    }
