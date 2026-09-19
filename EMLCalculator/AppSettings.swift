//
//  AppSettings.swift
//  EMLCalculator
//
//  Created by Nathan McCrina on 9/19/26.
//

import SwiftData

@Model
class AppSettings {
    var currency: Currencies
    
    init(currency: Currencies = Currencies.PHP) {
        self.currency = currency
    }
}
