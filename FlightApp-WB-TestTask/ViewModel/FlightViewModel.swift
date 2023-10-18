//
//  FlightViewModel.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 18.10.2023.
//

import SwiftUI

class FlightViewModel: ObservableObject {
    @Published var flights: [Flight] = []
    @Published var isLoading: Bool = true
    @Published var likedFlights: [Bool] = []

    init() {
        loadFlights()
    }
    
    func loadFlights() {
        isLoading = true
        
        guard let url = URL(string: "https://vmeste.wildberries.ru/stream/api/avia-service/v1/suggests/getCheap") else {
            return
        }
        
        let requestData: [String: Any] = ["startLocationCode": "LED"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestData)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let data = data, error == nil {
                    do {
                        let decoder = JSONDecoder()
                        let flightResponse = try decoder.decode(FlightData.self, from: data)
                        self.flights = flightResponse.flights ?? []
                        self.likedFlights = Array(repeating: false, count: self.flights.count)
                    }
                    catch {
                        print("Ошибка декодирования данных: \(error)")
                    }
                } else {
                    print("Ошибка загрузки данных: \(error?.localizedDescription ?? "Неизвестная ошибка")")
                }
            }
        }.resume()
    }
    
    func likeToggle(for flight: Flight) {
        if let index = flights.firstIndex(where: { $0.searchToken == flight.searchToken }) {
            likedFlights[index].toggle()
        }
    }
}

