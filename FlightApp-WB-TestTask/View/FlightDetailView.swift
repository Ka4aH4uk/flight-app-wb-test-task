//
//  FlightDetailView.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 18.10.2023.
//

import SwiftUI
import TipKit

struct FlightDetailView: View {
    @ObservedObject var viewModel: FlightViewModel
    @State var flight: Flight
    @State var isOnBaggage = false
    @State var isOnNotification = false
    @State var showAlert = false
    @State var ticketSeller: AirTicketSeller = .aviaSales
    @State var baggagePrice = AppConstants.Content.baggagePrice
    @State var selectedURL: URL?
    let likedFlightTip = LikedFlightTip()
    
    var totalFlightPrice: Int {
        return (flight.price ?? 0) + (isOnBaggage ? baggagePrice : 0)
    }
    
    enum AirTicketSeller: String, CaseIterable, Identifiable {
        case aviaSales = "Aviasales"
        case kupiBilet = "Купибилет"
        case aeroflot = "Аэрофлот"
        case ott = "OneTwoTrip"
        case wbTravel = "Wildberries Travel"
        var id: Self { self }
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
                    
                    HStack {
                        Text("\(flight.startCity?.rawValue ?? "") — \(flight.endCity ?? "")")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                    HStack {
                        Text("3ч 40м в пути")
                            .font(.subheadline)
                            .foregroundStyle(.black.opacity(0.5))
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                    VStack(spacing: 15) {
                        HStack {
                            Image(AppConstants.Design.Image.logo)
                                .resizable()
                                .frame(width: 30, height: 30)
                            VStack(alignment: .leading) {
                                Text(AppConstants.Content.airlineText)
                                    .font(.caption)
                                Text("3ч 40м в полете")
                                    .font(.caption)
                                    .foregroundStyle(.black.opacity(0.6))
                            }
                            Spacer()
                            Button { } label: {
                                NavigationLink {
                                    Image(AppConstants.Design.Image.airport)
                                    Text(AppConstants.Content.niceTripText)
                                        .font(.title).bold()
                                        .multilineTextAlignment(.center)
                                } label: {
                                    Label("Подробнее", systemImage: "info")
                                        .font(.caption2)
                                        .foregroundStyle(.white.opacity(0.9))
                                }
                            }
                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .background {
                                Capsule()
                                    .fill(.blue.opacity(0.6))
                            }
                        }
                        .padding(.leading, 20).padding(.trailing, 20).padding(.top, 10)
                        
                        HStack(spacing: 20) {
                            Image(systemName: "airplane.departure")
                            Text("\(flight.startLocationCode?.rawValue ?? "")")
                            Text("\(flight.formattedDate(dateString: flight.startDate))")
                            Spacer()
                        }
                        .fontWeight(.semibold)
                        .font(.headline)
                        .padding(.leading, 20).padding(.trailing, 20)
                        
                        HStack(spacing: 20) {
                            Image(systemName: "airplane.arrival")
                            Text("\(flight.endLocationCode ?? "")")
                            Text("\(flight.formattedDate(dateString: flight.startDate))")
                                .hidden()
                            Spacer()
                        }
                        .fontWeight(.semibold)
                        .font(.headline)
                        .padding(.leading, 20).padding(.trailing, 20).padding(.bottom, 15)
                    }
                    .background()
                    .cornerRadius(12)
                    .padding(.leading, 20).padding(.trailing, 20)
                    
                    HStack {
                        Text("\(flight.endCity ?? "") — \(flight.startCity?.rawValue ?? "")")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.leading, 20).padding(.top, 20)
                    
                    HStack {
                        Text("4ч 20м в пути")
                            .font(.subheadline)
                            .foregroundStyle(.black.opacity(0.5))
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                    VStack(spacing: 15) {
                        HStack {
                            Image(AppConstants.Design.Image.logo)
                                .resizable()
                                .frame(width: 30, height: 30)
                            VStack(alignment: .leading) {
                                Text(AppConstants.Content.airlineText)
                                    .font(.caption)
                                Text("4ч 20м в полете")
                                    .font(.caption)
                                    .foregroundStyle(.black.opacity(0.6))
                            }
                            Spacer()
                            Button { } label: {
                                NavigationLink {
                                    LottieView(name: AppConstants.Design.Lottie.lottieCap, loopMode: .repeat(1))
                                        .scaleEffect(0.6)
                                } label: {
                                    Label("Подробнее", systemImage: "info")
                                        .font(.caption2)
                                        .foregroundStyle(.white.opacity(0.9))
                                }
                            }
                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .background {
                                Capsule()
                                    .fill(.blue.opacity(0.6))
                            }
                        }
                        .padding(.leading, 20).padding(.trailing, 20).padding(.top, 10)
                        
                        HStack(spacing: 20) {
                            Image(systemName: "airplane.departure")
                            Text("\(flight.endLocationCode ?? "")")
                            Text("\(flight.formattedDate(dateString: flight.endDate?.rawValue))")
                            Spacer()
                        }
                        .fontWeight(.semibold)
                        .font(.headline)
                        .padding(.leading, 20).padding(.trailing, 20)
                        
                        HStack(spacing: 20) {
                            Image(systemName: "airplane.arrival")
                            Text("\(flight.startLocationCode?.rawValue ?? "")")
                            Text("\(flight.formattedDate(dateString: flight.endDate?.rawValue))")
                                .hidden()
                            Spacer()
                        }
                        .fontWeight(.semibold)
                        .font(.headline)
                        .padding(.leading, 20).padding(.trailing, 20).padding(.bottom, 15)
                    }
                    .background()
                    .cornerRadius(12)
                    .padding(.leading, 20).padding(.trailing, 20)
                    
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
            WebView(html: url.absoluteString)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isOnNotification.toggle()
                    showAlert.toggle()
                } label: {
                    Image(systemName: isOnNotification ? "bell.fill" : "bell")
                        .font(.title2)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(""),
                          message: isOnNotification ? Text("Создали подписку на билет \(flight.endCity ?? "") — \(flight.startCity?.rawValue ?? "") — \(flight.endCity ?? "")") : Text("Отменили подписку на билет \(flight.endCity ?? "") — \(flight.startCity?.rawValue ?? "") — \(flight.endCity ?? "")"),
                          dismissButton: .default(Text("ОК")))
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.likeToggle(for: flight)
                } label: {
                    Image(systemName: viewModel.likedFlights[viewModel.flights.firstIndex(where: { $0.searchToken == flight.searchToken }) ?? 0] ? "airplane.circle.fill" : "airplane.circle")
                        .foregroundColor(viewModel.likedFlights[viewModel.flights.firstIndex(where: { $0.searchToken == flight.searchToken }) ?? 0] ? .red : .blue.opacity(0.8))
                        .font(.title)
                        .popoverTip(likedFlightTip, arrowEdge: .top)
                }
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

struct LikedFlightTip: Tip {
    var title: Text {
        Text(AppConstants.Tip.titleTipText)
    }
    
    var message: Text? {
        Text(AppConstants.Tip.messageTipText)
    }
    
    var image: Image? {
        Image(systemName: "heart")
    }
    
    var options: [TipOption] {
        IgnoresDisplayFrequency(true)
        MaxDisplayCount(1)
    }
}

#Preview {
    let flightViewModel = FlightViewModel()
    
    return FlightDetailView(viewModel: flightViewModel, flight: Flight(startDate: "10-12-2024", endDate: .the000101010000000000UTC, startLocationCode: .led, endLocationCode: "SVO", startCity: .санктПетербург, endCity: "Москва", serviceClass: "", seats: [], price: 5980, searchToken: ""))
}
