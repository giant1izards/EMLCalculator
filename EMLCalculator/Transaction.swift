//
//  Transaction.swift
//  EMLCalculator
//
//  Created by Nathan McCrina on 9/18/26.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Transaction {
    var amount: Int
    var memo: String
    var date: Date
    var account: Account
    
    init(amount: Int, account: Account, date: Date, memo: String) {
        self.amount = amount
        self.account = account
        self.date = date
        self.memo = memo
    }
}

extension Transaction {
    static func transactionFilterPredicate(account: Account) -> Predicate<Transaction> {
        let accountId = account.id
        return #Predicate<Transaction> {
            $0.account.id == accountId
        }
    }
}
