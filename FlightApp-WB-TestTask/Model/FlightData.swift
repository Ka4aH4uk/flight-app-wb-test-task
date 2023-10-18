//
//  FlightData.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 18.10.2023.
//

import Foundation

// MARK: - FlightData
struct FlightData: Codable {
    let flights: [Flight]?
}

// MARK: - Flight
struct Flight: Codable {
    let startDate: String?
    let endDate: EndDate?
    let startLocationCode: StartLocationCode?
    let endLocationCode: String?
    let startCity: StartCity?
    let endCity: String?
    let serviceClass: String?
    let seats: [Seat]?
    let price: Int?
    let searchToken: String?
}

enum EndDate: String, Codable {
    case the000101010000000000UTC = "0001-01-01 00:00:00 +0000 UTC"
}

// MARK: - Seat
struct Seat: Codable {
    let passengerType: String?
    let count: Int?
}

enum StartCity: String, Codable {
    case санктПетербург = "Санкт-Петербург"
}

enum StartLocationCode: String, Codable {
    case led = "LED"
}
