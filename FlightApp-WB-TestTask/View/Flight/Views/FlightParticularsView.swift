//
//  FlightParticularsView.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 28.11.2023.
//

import SwiftUI

struct FlightParticularsView: View {
    let flight: Flight
    let isDeparture: Bool
    
    var body: some View {
        HStack {
            Text(isDeparture ? "\(flight.startCity?.rawValue ?? "") — \(flight.endCity ?? "")" : "\(flight.endCity ?? "") — \(flight.startCity?.rawValue ?? "")")
                .font(.headline)
            Spacer()
        }
        .padding(.leading, 20)
        
        HStack {
            Text(isDeparture ? AppConstants.Content.travelTime3h40m : AppConstants.Content.travelTime4h20m)
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
                    Text(isDeparture ? AppConstants.Content.inFlight3h40m : AppConstants.Content.inFlight4h20m)
                        .font(.caption)
                        .foregroundStyle(.black.opacity(0.6))
                }
                Spacer()
                
                if isDeparture {
                    Button { } label: {
                        NavigationLink {
                            Image(AppConstants.Design.Image.airport)
                            Text(AppConstants.Content.niceTripText)
                                .font(.title).bold()
                                .multilineTextAlignment(.center)
                        } label: {
                            Label(AppConstants.Content.moreDetails, systemImage: "info")
                                .font(.caption2)
                                .foregroundStyle(.white.opacity(0.9))
                        }
                    }
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .background {
                        Capsule()
                            .fill(.blue.opacity(0.6))
                    }
                } else {
                    Button { } label: {
                        NavigationLink {
                            LottieView(name: AppConstants.Design.Lottie.lottieCap,
                                       loopMode: .repeat(1),
                                       animationSpeed: 0.5)
                            .scaleEffect(0.6)
                        } label: {
                            Label(AppConstants.Content.moreDetails, systemImage: "info")
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
            }
            .padding(.leading, 20).padding(.trailing, 20).padding(.top, 10)
            
            HStack(spacing: 20) {
                Image(systemName:"airplane.departure")
                Text(isDeparture ? "\(flight.startLocationCode?.rawValue ?? "")" : "\(flight.endLocationCode ?? "")")
                Text(isDeparture ? "\(flight.formattedDate(dateString: flight.startDate))" : "\(flight.formattedDate(dateString: flight.endDate?.rawValue))")
                Spacer()
            }
            .fontWeight(.semibold)
            .font(.headline)
            .padding(.leading, 20).padding(.trailing, 20)
            
            HStack(spacing: 20) {
                Image(systemName: "airplane.arrival")
                Text(isDeparture ? "\(flight.endLocationCode ?? "")" : "\(flight.startLocationCode?.rawValue ?? "")")
                Text(isDeparture ? "\(flight.formattedDate(dateString: flight.startDate))": "\(flight.formattedDate(dateString: flight.endDate?.rawValue))")
                    .hidden()
                Spacer()
            }
            .fontWeight(.semibold)
            .font(.headline)
            .padding(.leading, 20).padding(.trailing, 20).padding(.bottom, 15)
        }
        .background()
        .cornerRadius(12)
        .padding(.leading, 20).padding(.trailing, 20).padding(.bottom, 15)        
    }
}

#Preview {
    FlightParticularsView(flight: Flight(startDate: "2023-12-14 00:00:00 +0000 UTC", endDate: .the000101010000000000UTC, startLocationCode: .led, endLocationCode: "SVO", startCity: .санктПетербург, endCity: "Москва", serviceClass: "", seats: [], price: 6106, searchToken: "LED141223MOWY200"), isDeparture: true)
}
