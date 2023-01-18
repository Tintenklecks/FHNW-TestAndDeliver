// Created 16.01.23

@testable import Test_And_Deliver
import XCTest

final class StringTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPalindrome() {
        // Test for positive number
        let result = Int.factorial(n: 5)
        XCTAssertEqual(result, 120, "Test with 120")
        // Test for zero
        let result2 = Int.factorial(n: 0)
        assert(result2 == 1)
        
        // more?????
        
    }

}
