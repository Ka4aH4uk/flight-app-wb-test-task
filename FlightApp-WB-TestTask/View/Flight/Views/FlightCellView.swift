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
    let randomNum = Int.random(in: 5...9)
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Group {
                        Text("\(flight.price ?? 0) \u{20BD}")
                            .font(.title).bold()
                        Text("Осталось \(randomNum) билетов по этой цене")
                            .font(.caption2)
                            .foregroundStyle(.red.opacity(0.9))

                        HStack(spacing: 10) {
                            Image(systemName: "airplane.departure")
                            Text("\(flight.startCity?.rawValue ?? "")")
                            Spacer()
                        }
                        .fontWeight(.medium)
                        
                        HStack(spacing: 10) {
                            Image(systemName: "airplane.arrival")
                            Text("\(flight.endCity ?? "")")
                            Spacer()
                        }
                        .fontWeight(.medium)
                        
                        Text("Дата отправления: \(flight.formattedDate(dateString: flight.startDate))")
                        Text("Дата возвращения: \(flight.formattedDate(dateString: flight.endDate?.rawValue))")
                    }
                    .font(.footnote)
                    .foregroundStyle(.black)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Image(systemName: viewModel.likedFlights[viewModel.flights.firstIndex(where: { $0.searchToken == flight.searchToken }) ?? 0] ? "airplane.circle.fill" : "airplane.circle")
                        .foregroundColor(viewModel.likedFlights[viewModel.flights.firstIndex(where: { $0.searchToken == flight.searchToken }) ?? 0] ? .red : .blue.opacity(0.8))
                        .font(.title2)
                    Spacer()
                    HStack {
                        Image(AppConstants.Design.Image.logo)
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
            }
        }
    }
}

#Preview {
    let viewModel = FlightViewModel()
    
    return FlightCellView(viewModel: viewModel, flight: Flight(startDate: "2024-01-02 00:00:00 +0000 UTC", endDate: .the000101010000000000UTC, startLocationCode: .led, endLocationCode: "KLF", startCity: .санктПетербург, endCity: "Калуга", serviceClass: "", seats: [], price: 3860, searchToken: "LED020124KLFY100"))
}
