//
//  LoadingWebView.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 28.11.2023.
//

import SwiftUI

struct LoadingWebView: View {
    @State private var isLoading = true
    @State private var error: Error? = nil
    @State var ticketSeller: AirTicketSeller
    let url: URL?

    var body: some View {
        NavigationStack {
            ZStack {
                if let error = error {
                    VStack() {
                        Image(systemName: "xmark.octagon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .padding()
                        Text(error.localizedDescription)
                            .multilineTextAlignment(.center)
                            .font(.title3)
                    }
                    .foregroundStyle(.red)
                    .padding()
                } else if let url = url {
                    WebView(url: url,
                            isLoading: $isLoading,
                            error: $error)
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .scaleEffect(1.5)
                    }
                } else {
                    Text("Sorry, we could not load this url.")
                }
            }
            .navigationBarTitle(ticketSeller.rawValue, displayMode: .inline)
        }
    }
}

#Preview {
    LoadingWebView(ticketSeller: AirTicketSeller.aviaSales, url: URL(string: "https://www.aviasales.ru")!)
}
