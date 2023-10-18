//
//  AppConstants.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 19.10.2023.
//


import SwiftUI

struct AppConstants {
    struct Content {
        static let baggagePrice: Int = 1859
        
        static let bestPriceText = "Лучшая цена за 1 пассажира"
        static let baggageOnText = "Багаж включен"
        static let baggageOffText = "Без багажа"
        static let addBaggageText = "Добавить багаж"
        static let niceTripText = "Приятного полёта и\n мягкой посадки!"
        static let airlineText = "FlightApp"
    }
    
    struct Tip {
        static let titleTipText = "Добавляй в избранное"
        static let messageTipText = "Ты можешь добавлять в избранное понравившиеся авиабилеты, чтобы не потерять"
    }
    
    struct Design {
        struct Lottie {
            static let lottieFlight = "flight"
            static let lottieCap = "cap"
        }
        
        struct Image {
            static let ticket = "ticket"
            static let suitcase = "suitcase"
            static let logo = "logo"
            static let airport = "airport"
        }
        
        struct Colors {
            static let gradientIndigoBlue = [Color.indigo.opacity(0.1), Color.blue.opacity(0.3)]
        }
    }
    
    struct API {
        static let wildberriesTravelApiURL = "https://vmeste.wildberries.ru/stream/api/avia-service/v1/suggests/getCheap"
        
        static let aviaSalesURL = "https://www.aviasales.ru"
        static let kupibiletURL = "https://www.kupibilet.ru"
        static let aeroflotURL = "https://www.aeroflot.ru"
        static let ottURL = "https://www.onetwotrip.com"
        static let wbTravelURL =  "https://vmeste.wildberries.ru"
    }
}
