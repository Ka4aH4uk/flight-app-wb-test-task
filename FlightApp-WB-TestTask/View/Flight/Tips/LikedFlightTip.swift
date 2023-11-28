//
//  LikedFlightTip.swift
//  FlightApp-WB-TestTask
//
//  Created by K4 on 28.11.2023.
//

import SwiftUI
import TipKit

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
