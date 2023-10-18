//
//  NetworkManager.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 18.10.2023.
//

import Alamofire
import Foundation

class FlightService: ObservableObject {
    static let shared = FlightService()

        func getFlights(completion: @escaping ([Flight]?, Error?) -> Void) {
            let url = "https://vmeste.wildberries.ru/stream/api/avia-service/v1/suggests/getCheap"
            
            let requestData: [String: String] = ["startLocationCode": "LED"]

            AF.request(
                url,
                method: .post,
                parameters: requestData,
                encoding: JSONEncoding.default
            ).responseDecodable(of: FlightData.self) { response in
                switch response.result {
                    case .success(let flightResponse):
                        let flights = flightResponse.flights ?? []
                        completion(flights, nil)
                    case .failure(let error):
                        completion(nil, error)
                    }
                }
        }
}
