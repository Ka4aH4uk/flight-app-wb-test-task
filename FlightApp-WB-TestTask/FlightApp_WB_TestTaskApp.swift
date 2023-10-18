//
//  FlightApp_WB_TestTaskApp.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 18.10.2023.
//

import SwiftUI

@main
struct FlightApp_WB_TestTaskApp: App {
    var body: some Scene {
        WindowGroup {
            FlightView()
                .environment(\.locale, .init(identifier: "ru_RU"))
                .preferredColorScheme(.light)
        }
    }
}
