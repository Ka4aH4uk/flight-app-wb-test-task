//
//  Extension.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 18.10.2023.
//

import SwiftUI

extension Flight {
    func formattedDate(dateString: String?) -> String {
        if let dateString = dateString {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzzz 'UTC'"
            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                return dateFormatter.string(from: date)
            }
        }
        return "N/A"
    }
}

extension URL: Identifiable {
    public var id: Int {
        hashValue
    }
}
