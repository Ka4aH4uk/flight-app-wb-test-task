//
//  FlightView.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 18.10.2023.
//

import SwiftUI

struct FlightView: View {
    @ObservedObject var viewModel = FlightViewModel()
    @State private var progress = 0.0
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    VStack {
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        LottieView(name: AppConstants.Design.Lottie.lottieFlight)
                            .scaleEffect(0.3)
                            .opacity(0.9)
                            .frame(width: 20, height: 20)
                    }
                    VStack {
                        VStack {
                            Spacer()
                            Gauge(value: progress, in: 0...100) {
                                Text("Подготовка к взлету! 🚀")
                                    .font(.headline)
                                    .padding()
                            }
                            .padding(.bottom, 50)
                            .tint(Gradient(colors: [.blue.opacity(0.3), .indigo.opacity(0.4)]))
                            .gaugeStyle(.linearCapacity)
                            .frame(width: 250, height: 50)
                            .onReceive(timer) { _ in
                                withAnimation(
                                    .easeOut(duration: 5.0)
                                    .delay(0.2)) {
                                        progress = 100.0
                                    }
                            }
                        }
                    }
                } else if viewModel.error != nil {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.red)
                } else {
                    Image(AppConstants.Design.Image.ticket)
                        .overlay {
                            HStack {
                                Image(AppConstants.Design.Image.suitcase)                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.top, 15).padding(.leading, 20)
                                Spacer()
                            }
                            .padding()
                        }
                        .shadow(color: .blue, radius: 1, x: 0, y: 0)
                    
                    List(viewModel.flights, id: \.searchToken) { flight in
                        NavigationLink {
                            FlightDetailView(viewModel: viewModel, flight: flight)
                        } label: {
                            FlightCellView(viewModel: viewModel, flight: flight)
                        }
                        .padding(15)
                        .background(
                            LinearGradient(gradient: Gradient(colors: AppConstants.Design.Colors.gradientIndigoBlue), startPoint: .top, endPoint: .bottom)
                                .cornerRadius(12)
                        )
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationBarTitle(viewModel.isLoading ? "" : "Авиабилеты", displayMode: .inline)
        }
        .alert(isPresented: Binding<Bool>(
            get: { viewModel.error != nil },
            set: { _ in viewModel.error = nil }
        )) {
            Alert(
                title: Text("Ошибка"),
                message: Text(viewModel.error?.localizedDescription ?? "Произошла ошибка при загрузке данных."),
                dismissButton: .default(Text("OK")) {
                    viewModel.loadFlights()
                    progress = 0.0
                }
            )
        }
    }
}

#Preview {
    FlightView()
}
