//
//  FlightDetailView.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 18.10.2023.
//

import SwiftUI
import TipKit

enum AirTicketSeller: String, CaseIterable, Identifiable {
    case aviaSales = "Aviasales"
    case kupiBilet = "Купибилет"
    case aeroflot = "Аэрофлот"
    case ott = "OneTwoTrip"
    case wbTravel = "Wildberries Travel"
    var id: Self { self }
}

struct FlightDetailView: View {
    @ObservedObject var viewModel: FlightViewModel
    @State var flight: Flight
    @State var isOnBaggage = false
    @State var isOnNotification = false
    @State var showAlert = false
    @State var ticketSeller: AirTicketSeller = .aviaSales
    @State var baggagePrice = AppConstants.Content.baggagePrice
    @State var selectedURL: URL?
    
    var totalFlightPrice: Int {
        return (flight.price ?? 0) + (isOnBaggage ? baggagePrice : 0)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    HStack {
                        Text("\(totalFlightPrice) \u{20BD}")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .padding(.top)
                    
                    Text(AppConstants.Content.bestPriceText)
                        .font(.callout)
                    HStack(alignment: .center) {
                        Text("На")
                            .font(.callout)
                        Picker(selection: $ticketSeller) {
                            Text(AirTicketSeller.aviaSales.rawValue).tag(AirTicketSeller.aviaSales)
                            Text(AirTicketSeller.kupiBilet.rawValue).tag(AirTicketSeller.kupiBilet)
                            Text(AirTicketSeller.aeroflot.rawValue).tag(AirTicketSeller.aeroflot)
                            Text(AirTicketSeller.ott.rawValue).tag(AirTicketSeller.ott)
                            Text(AirTicketSeller.wbTravel.rawValue).tag(AirTicketSeller.wbTravel)
                        } label: { }.padding(-10)
                    }
                    
                    Form {
                        if isOnBaggage {
                            Text(AppConstants.Content.baggageOnText)
                                .foregroundStyle(.green)
                        } else {
                            Text(AppConstants.Content.baggageOffText)
                                .foregroundStyle(.black)
                        }
                        Toggle(isOn: $isOnBaggage) {
                            HStack {
                                Image(systemName: "suitcase.rolling.fill")
                                    .foregroundStyle(isOnBaggage ? .green : .black)
                                Text(AppConstants.Content.addBaggageText)
                                
                                if isOnBaggage {
                                    Text("")
                                } else {
                                    Text("+\(baggagePrice) \u{20BD}")
                                        .foregroundStyle(.blue)
                                        .font(.subheadline).bold()
                                }
                            }
                        }
                    }
                    .frame(height: 150)
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                    .background(.clear)
                    .padding(.top, -20)
                    
                    FlightParticularsView(flight: flight, isDeparture: true)
                    
                    FlightParticularsView(flight: flight, isDeparture: false)
                    
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    Button {
                        let url: URL?
                        switch ticketSeller {
                        case .aviaSales:
                            url = URL(string: AppConstants.API.aviaSalesURL)
                        case .kupiBilet:
                            url = URL(string: AppConstants.API.kupibiletURL)
                        case .aeroflot:
                            url = URL(string: AppConstants.API.aeroflotURL)
                        case .ott:
                            url = URL(string: AppConstants.API.ottURL)
                        case .wbTravel:
                            url = URL(string: AppConstants.API.wbTravelURL)
                        }
                        
                        if let url = url {
                            selectedURL = url
                        }
                    } label: {
                        Text("Купить билет за \(totalFlightPrice) \u{20BD}")
                            .foregroundStyle(.white)
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.orange.gradient)
                    .cornerRadius(12)
                    .padding(.leading, 20).padding(.trailing, 20).padding(.bottom)
                }
                .navigationBarTitle("", displayMode: .inline)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: AppConstants.Design.Colors.gradientIndigoBlue), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            )
        }
        .sheet(item: $selectedURL) { url in
            NavigationStack {
                LoadingWebView(ticketSeller: ticketSeller.id, url: url)
                    .navigationBarItems(trailing: Button(action: {
                        selectedURL = nil
                    }, label: {
                        Image(systemName: "xmark.circle")
                    }))
                    .onDisappear {
                        selectedURL = nil
                    }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NotificationButton(isOnNotification: $isOnNotification,
                                   showAlert: $showAlert,
                                   flight: flight)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                LikeButton(viewModel: viewModel, flight: flight)
            }
        }
        .task {
            try? Tips.configure([
                .displayFrequency(.monthly),
                .datastoreLocation(.applicationDefault)
            ])
        }
    }
}

#Preview {
    let flightViewModel = FlightViewModel()
    
    return FlightDetailView(viewModel: flightViewModel, flight: Flight(startDate: "2023-12-14 00:00:00 +0000 UTC", endDate: .the000101010000000000UTC, startLocationCode: .led, endLocationCode: "SVO", startCity: .санктПетербург, endCity: "Москва", serviceClass: "", seats: [], price: 6106, searchToken: "LED141223MOWY200"))
}
