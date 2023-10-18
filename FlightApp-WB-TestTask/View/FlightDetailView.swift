//
//  FlightDetailView.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 18.10.2023.
//

import SwiftUI
import TipKit

struct FlightDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: FlightViewModel
    @State var flight: Flight
    @State var isOnBaggage = false
    @State var isOnNotification = false
    @State var receiveNotification = false
    @State private var ticketSeller: AirTicketSeller = .aviaSales
    private let likedFlightTip = LikedFlightTip()
    
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
                LinearGradient(colors: [.indigo.opacity(0.1), .blue.opacity(0.3)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("\(Int(flight.price ?? 0)) \u{20BD}")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }.padding(.top)
                    
                    Text("Лучшая цена за 1 пассажира")
                        .font(.callout)
                    HStack(alignment: .center) {
                        Text("На")
                            .font(.callout)
                        Picker(selection: $ticketSeller) {
                            Text(AirTicketSeller.aviaSales.rawValue.capitalized).tag(AirTicketSeller.aviaSales)
                            Text(AirTicketSeller.kupiBilet.rawValue.capitalized).tag(AirTicketSeller.kupiBilet)
                            Text(AirTicketSeller.aeroflot.rawValue.capitalized).tag(AirTicketSeller.aeroflot)
                            Text(AirTicketSeller.ott.rawValue.capitalized).tag(AirTicketSeller.ott)
                            Text(AirTicketSeller.wbTravel.rawValue.capitalized).tag(AirTicketSeller.wbTravel)
                        } label: { }.padding(-10)
                    }
                    
                    List {
                        Section(header: Text("Багаж").bold(true)) {
                            Text(isOnBaggage ? "Багаж включен" : "Без багажа")
                                .foregroundStyle(isOnBaggage ? .green : .black)
                            Toggle(isOn: $isOnBaggage) {
                                HStack {
                                    Image(systemName: "suitcase.rolling.fill")
                                        .foregroundStyle(isOnBaggage ? .green : .black)
                                    Text("Добавить багаж")
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
                        Text("\(flight.startCity?.rawValue ?? "") - \(flight.endCity ?? "")")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.leading)
                    
                    HStack {
                        Text("\(flight.endCity ?? "") - \(flight.startCity?.rawValue ?? "")")
                            .font(.headline)
                        Spacer()
                    }
                    .padding()//.leading)
                    
                    Form {
                        Section(header: Text("Уведомления").bold(true)) {
                            Toggle("Получать уведомления?", isOn: $isOnNotification)
                            if isOnNotification {
                                Toggle("Изменение цены", isOn: $receiveNotification)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                    .background(.clear)
                    
                    Group {
                        Text("Город отправления: \(flight.startCity?.rawValue ?? "")")
                        Text("Город прибытия: \(flight.endCity ?? "")")
                        Text("Дата отправления: \(flight.startDate ?? "")")
                        Text("Дата возвращения: \(flight.endDate?.rawValue ?? "")")
                        Text("Цена в рублях: \(flight.price ?? 0)")
                    }
                    .font(.title2)
                    
                    Spacer()
                }
                .navigationBarTitle(Text(""), displayMode: .inline)
            }
            .navigationBarItems(trailing: Button(action: {
                viewModel.likeToggle(for: flight)
            }, label: {
                Image(systemName: viewModel.likedFlights[viewModel.flights.firstIndex(where: { $0.searchToken == flight.searchToken }) ?? 0] ? "heart.fill" : "heart")
                    .foregroundColor(viewModel.likedFlights[viewModel.flights.firstIndex(where: { $0.searchToken == flight.searchToken }) ?? 0] ? .red : .black.opacity(0.8))
                    .font(.title3)
            }))
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Все билеты")
                    }
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
        Text("Добавляй в избранное")
    }
    
    var message: Text? {
        Text("Ты можешь добавлять в избранное понравившиеся авиабилеты, чтобы не потерять")
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

