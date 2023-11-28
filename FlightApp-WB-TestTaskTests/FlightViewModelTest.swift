//
//  FlightViewModelTest.swift
//  FlightApp-WB-TestTaskTests
//
//  Created by K4 on 28.11.2023.
//

import XCTest
@testable import FlightApp_WB_TestTask

final class FlightViewModelTests: XCTestCase {
    var viewModel: FlightViewModel!

    override func setUp() {
        super.setUp()
        viewModel = FlightViewModel(flightService: MockFlightService())
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func test_Load_Flights_Success() {
        /// Given
        let expectation = XCTestExpectation(description: "Load flights successfully")
        viewModel.loadFlights()

        /// Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNotNil(self.viewModel.flights)
            XCTAssertEqual(self.viewModel.likedFlights, Array(repeating: false, count: self.viewModel.flights.count))
            XCTAssertNil(self.viewModel.error)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }

    func test_Load_Flights_Failure() {
        /// Given
        let expectation = XCTestExpectation(description: "Load flights failed")
        viewModel = FlightViewModel(flightService: ErrorMockFlightService())
        viewModel.loadFlights()
        
        /// Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            XCTAssertNotNil(self.viewModel.error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_Like_Toggle() {
        /// Given
        let flight = Flight(startDate: "2023-12-14 00:00:00 +0000 UTC", endDate: .the000101010000000000UTC, startLocationCode: .led, endLocationCode: "SVO", startCity: .санктПетербург, endCity: "Москва", serviceClass: "", seats: [], price: 6106, searchToken: "LED141223MOWY200")
        
        viewModel.flights = [flight]
        viewModel.likedFlights = Array(repeating: false, count: viewModel.flights.count)

        /// When
        viewModel.likeToggle(for: flight)

        /// Then
        XCTAssertTrue(viewModel.likedFlights.first ?? false)
        XCTAssertEqual(viewModel.likedFlights.count, viewModel.flights.count)
    }
}

//MARK: - Фиктивный FlightService
class MockFlightService: FlightServiceProtocol {
    func getFlights(completion: @escaping ([Flight]?, Error?) -> Void) {
        let testFlight = Flight(startDate: "2023-12-14 00:00:00 +0000 UTC", endDate: .the000101010000000000UTC, startLocationCode: .led, endLocationCode: "SVO", startCity: .санктПетербург, endCity: "Москва", serviceClass: "", seats: [], price: 6106, searchToken: "LED141223MOWY200")
        completion([testFlight], nil)
    }
}

class ErrorMockFlightService: FlightServiceProtocol {
    func getFlights(completion: @escaping ([Flight]?, Error?) -> Void) {
        let error = NSError(domain: "com.example.invalid", code: 500, userInfo: nil)
        completion(nil, error)
    }
}
