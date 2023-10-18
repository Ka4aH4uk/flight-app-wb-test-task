//
//  FlightCellView.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 18.10.2023.
//

import SwiftUI

struct FlightCellView: View {
    @StateObject var viewModel: FlightViewModel
    var flight: Flight
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Group {
                        Text("Отправление из: \(flight.startCity?.rawValue ?? "")")
                        Text("Прибытие в: \(flight.endCity ?? "")")
                        Text("Вылет: \(flight.startDate ?? "")")
                        Text("Возвращение: \(flight.endDate?.rawValue ?? "")")
                        Text("Цена: \(Int(flight.price ?? 0)) \u{20BD}")
                    }
                    .lineLimit(1)
                    .font(.callout)
                    .foregroundStyle(.black.opacity(0.8))
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Image(systemName: viewModel.likedFlights[viewModel.flights.firstIndex(where: { $0.searchToken == flight.searchToken }) ?? 0] ? "airplane.circle.fill" : "airplane.circle")
                        .foregroundColor(viewModel.likedFlights[viewModel.flights.firstIndex(where: { $0.searchToken == flight.searchToken }) ?? 0] ? .red : .blue.opacity(0.8))
                        .font(.title2)
                    Spacer()
                }
            }
            .padding()
        }
    }
}

#Preview {
    let viewModel = FlightViewModel()
    
    return FlightCellView(viewModel: viewModel, flight: Flight(startDate: "2024-01-02 00:00:00 +0000 UTC", endDate: .the000101010000000000UTC, startLocationCode: .led, endLocationCode: "KLF", startCity: .санктПетербург, endCity: "Калуга", serviceClass: "", seats: [], price: 3860, searchToken: "LED020124KLFY100"))
}

