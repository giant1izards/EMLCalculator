//
//  SettingsView.swift
//  EMLCalculator
//
//  Created by Nathan McCrina on 9/19/26.
//

import SwiftData
import SwiftUI

struct SettingsView : View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query() var settings: [AppSettings]
    
    @State private var selectedCurrency: Currencies = .PHP
    
    var body: some View {
        Form {
            Picker("Currency", selection: $selectedCurrency) {
                ForEach(Currencies.allCases) { currency in
                    Text(Currency.currencies[currency]!)
                }
            }
        }
        .onAppear {
            if let s = settings.first {
                selectedCurrency = s.currency
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Settings")
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    if let settings = settings.first {
                        settings.currency = selectedCurrency
                    }
                    else {
                        let settings = AppSettings(currency: selectedCurrency)
                        context.insert(settings)
                    }
                    dismiss()
                }
            }
        }
    }
}
