//
//  FlightApp_WB_TestTaskTests.swift
//  FlightApp-WB-TestTaskTests
//
//  Created by K4 on 27.11.2023.
//

import XCTest
@testable import FlightApp_WB_TestTask

// MARK: - FlightService
final class FlightServiceTest: XCTestCase {
    var flightService: FlightService!
    
    override func setUp() {
        super.setUp()
        flightService = FlightService()
    }
    
    override func tearDown() {
        flightService = nil
        super.tearDown()
    }
    
    func test_Get_Flights_Success() {
        /// Given
        let expectation = XCTestExpectation(description: "Get flights successfully")
        flightService.isTestingMode = false

        /// When
        flightService.getFlights { flights, error in
            /// Then
            XCTAssertNotNil(flights)
            XCTAssertNil(error)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func test_Get_Flights_Failure() {
        /// Given
        let expectation = XCTestExpectation(description: "Get flights failed")
        flightService.isTestingMode = true

        /// When
        flightService.getFlights { flights, error in
            /// Then
            XCTAssertNil(flights)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
}
