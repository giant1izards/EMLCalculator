//
//  SettingsContext.swift
//  EMLCalculator
//
//  Created by Nathan McCrina on 9/19/26.
//

import SwiftUI

@Observable
class SettingsContext {
    var settings: AppSettings
    
    init(settings: AppSettings = AppSettings()) {
        self.settings = settings
    }
}
