//
//  LikeButton.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 28.11.2023.
//

import SwiftUI

struct LikeButton: View {
    @ObservedObject var viewModel: FlightViewModel
    let flight: Flight
    let likedFlightTip = LikedFlightTip()

    var body: some View {
        Button {
            viewModel.likeToggle(
                for: flight
            )
        } label: {
            Image(
                systemName: viewModel.likedFlights[viewModel.flights.firstIndex(where: {
                    $0.searchToken == flight.searchToken
                }) ?? 0] ? "airplane.circle.fill" : "airplane.circle"
            )
            .foregroundColor(
                viewModel.likedFlights[viewModel.flights.firstIndex(where: {
                    $0.searchToken == flight.searchToken
                }) ?? 0] ? .red : .blue.opacity(
                    0.8
                )
            )
            .font(
                .title
            )
            .popoverTip(
                likedFlightTip,
                arrowEdge: .top
            )
        }
    }
}
