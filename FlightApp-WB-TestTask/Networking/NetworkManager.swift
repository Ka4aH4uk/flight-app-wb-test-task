//
//  NetworkManager.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 18.10.2023.
//

import Alamofire
import Foundation

protocol FlightServiceProtocol {
    func getFlights(completion: @escaping ([Flight]?, Error?) -> Void)
}

class FlightService: FlightServiceProtocol {
    var isTestingMode = false
    
    func getFlights(completion: @escaping ([Flight]?, Error?) -> Void) {
        if isTestingMode {
            let error = NSError(domain: "Test Domain", code: 404, userInfo: nil)
            completion(nil, error)
        } else {
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
}
