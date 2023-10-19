//
//  NetworkManager.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 18.10.2023.
//

import Alamofire

protocol FlightServiceProtocol {
    func getFlights(completion: @escaping ([Flight]?, Error?) -> Void)
}

class FlightService: FlightServiceProtocol {
    func getFlights(completion: @escaping ([Flight]?, Error?) -> Void) {
        let url = AppConstants.API.wildberriesTravelApiURL
        
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
