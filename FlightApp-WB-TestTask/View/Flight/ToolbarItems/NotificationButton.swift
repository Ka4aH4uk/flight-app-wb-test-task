//
//  NotificationButton.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 28.11.2023.
//

import SwiftUI

struct NotificationButton: View {
    @Binding var isOnNotification: Bool
    @Binding var showAlert: Bool
    let flight: Flight

    var body: some View {
        Button {
            isOnNotification.toggle()
            showAlert.toggle()
        } label: {
            Image(systemName: isOnNotification ? "bell.fill" : "bell")
                .font(.title2)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(""),
                message: isOnNotification ?
                    Text("Создали подписку на билет \(flight.endCity ?? "") — \(flight.startCity?.rawValue ?? "") — \(flight.endCity ?? "")") :
                    Text("Отменили подписку на билет \(flight.endCity ?? "") — \(flight.startCity?.rawValue ?? "") — \(flight.endCity ?? "")"),
                dismissButton: .default(Text("ОК"))
            )
        }
    }
}
