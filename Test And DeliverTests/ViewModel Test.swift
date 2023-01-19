// Created 16.01.23

@testable import Test_And_Deliver
import XCTest

final class ViewModelTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAsyncService() async throws {
        let service = MockService()
        let owmService = OWMService(service: service)
        let forecast = try await owmService.getForecast(lat: 12, lon: 34)
        XCTAssertEqual(forecast.city.name, "Mocked Brugg")
    }
    
    func testServiceWithHandler() {
        let service = MockService()
        let owmService = OWMService(service: service)
        var forecast: OWMForecast?
        
        let expectation = self.expectation(description: "service with handler")
        
        owmService.getForecast(lat: 12, lon: 34) { result in
            switch result {
            case .success(let forecastResult):
                forecast = forecastResult
                expectation.fulfill()
            case .failure:
                forecast = nil
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertEqual(forecast?.city.name, "Mocked Brugg")
    }
}
