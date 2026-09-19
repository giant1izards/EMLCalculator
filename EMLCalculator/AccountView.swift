//
//  AccountView.swift
//  EMLCalculator
//
//  Created by Nathan McCrina on 9/18/26.
//

import Foundation
import SwiftData
import SwiftUI

struct AccountView : View {
    private let account: Account
    
    @Environment(\.modelContext) private var context
#if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private var isCompact: Bool { horizontalSizeClass == .compact }
#else
    private let isCompact = false
#endif
    
    @Query(sort: \Transaction.date) private var transactions: [Transaction]
    
    init(account: Account) {
        self.account = account
        
        _transactions = Query(filter: Transaction.transactionFilterPredicate(account: account), sort: \Transaction.date)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Name:")
                Text(account.name)
            }
            HStack {
                Text("Expense:")
                Text(getAmountOwed().description).foregroundStyle(getAmountOwed() > 0 ? .red : .green)
            }
            Table(transactions) {
                TableColumn("Date") { t in
                    VStack(alignment: .leading) {
                        Text(t.date.formatted(date: .abbreviated, time: .omitted))
                        if isCompact {
                            Text(t.memo)
                            Text("\(t.amount)").foregroundStyle(t.amount < 0 ? .green : .red)
                            Button(action: {
                                context.delete(t)
                            }) {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                TableColumn("Memo", value: \.memo)
                TableColumn("Amount") { t in
                    Text("\(t.amount)").foregroundStyle(t.amount < 0 ? .green : .red)
                }
                TableColumn("") { t in
                    Button(action: {
                        context.delete(t)
                    }) {
                        Label("", systemImage: "trash")
                    }
                }
            }
        }
    }
    
    private func getAmountOwed() -> Int {
        let total = transactions.reduce(0, { total, transaction in
            return total + transaction.amount
        })
        
        return total < 0 ? 0 : total
    }
}
