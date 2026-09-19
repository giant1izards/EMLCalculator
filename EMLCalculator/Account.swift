//
//  Account.swift
//  EMLCalculator
//
//  Created by Nathan McCrina on 9/18/26.
//

import Foundation
import SwiftData

@Model
final class Account {
    @Attribute(.unique) var name: String
    @Relationship(deleteRule: .cascade, inverse: \Transaction.account) var transactions: [Transaction]
    
    init(name: String, transactions: [Transaction] = []) {
        self.name = name
        self.transactions = transactions
    }
}
