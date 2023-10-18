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
    @Published var error: Error? = nil
    
    init() {
        loadFlights()
    }
    
    func loadFlights() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            FlightService.shared.getFlights { [weak self] flights, error in
                guard let self = self else {
                    return
                }
                
                self.isLoading = false
                
                if let error = error {
                    self.error = error
                    print("Ошибка загрузки данных: \(error.localizedDescription)")
                } else {
                    self.flights = flights ?? []
                    self.likedFlights = Array(repeating: false, count: self.flights.count)
                }
            }
        }
    }
    
    func likeToggle(for flight: Flight) {
        if let index = flights.firstIndex(where: { $0.searchToken == flight.searchToken }) {
            likedFlights[index].toggle()
        }
    }
}
