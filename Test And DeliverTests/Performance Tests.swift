// Created 16.01.23

@testable import Test_And_Deliver
import XCTest

final class PerformanceTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFibonacciPerformanceRecursive() throws {
        // This is an example of a performance test case.
        self.measure {

            _ = Int.fib(20)
        }
    }
    
    func testFibonacciPerformanceLinear() throws {
        // This is an example of a performance test case.
        self.measure {

            _ = Int.fibonacci(n: 20)
        }
    }
}
