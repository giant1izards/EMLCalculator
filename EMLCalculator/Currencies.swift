//
//  Currencies.swift
//  EMLCalculator
//
//  Created by Nathan McCrina on 9/19/26.
//

struct Currency {
    static var currencies = [
        Currencies.PHP: "₱",
        Currencies.USD: "$"
    ]
    
    static func getConfiguredSymbol(settings: [AppSettings]) -> String {
        return Currency.currencies[settings.first?.currency ?? .PHP]!
    }
}

enum Currencies : String, CaseIterable, Identifiable, Codable {
    case PHP = "PHP",
        USD = "USD"
    var id: Self { self }
}
