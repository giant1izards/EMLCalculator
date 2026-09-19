//
//  TransactionRecipientView.swift
//  EMLCalculator
//
//  Created by Nathan McCrina on 9/18/26.
//

import SwiftUI

struct TransactionRecipientView : View {
    var accountName: String
    var amountOwed: Int
    
    var body: some View {
        HStack {
            Text(accountName)
            Text(amountOwed.description)
        }
    }
}
