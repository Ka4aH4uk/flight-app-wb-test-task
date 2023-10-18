//
//  FlightView.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 18.10.2023.
//

import SwiftUI

struct FlightView: View {
    @ObservedObject var viewModel = FlightViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    LottieView(name: "flight")
                        .scaleEffect(0.3)
                        .opacity(0.9)
                        .frame(width: 20, height: 20)
                } else {
                    Image("ticket")
                        .overlay {
                            HStack {
                                Image("suitcase")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.top, 15).padding(.leading, 20)
                                Spacer()
                            }
                            .padding()
                        }
                        .padding()
                    
                    List(viewModel.flights, id: \.searchToken) { flight in
                        NavigationLink {
                            FlightDetailView(viewModel: viewModel, flight: flight)
                        } label: {
                            FlightCellView(viewModel: viewModel, flight: flight)
                        }
                        .padding(15)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.indigo.opacity(0.1), .blue.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
                                .cornerRadius(12)
                        )
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationBarTitle(viewModel.isLoading ? "" : "Авиабилеты", displayMode: .large)
        }
    }
}

#Preview {
    FlightView()
}
