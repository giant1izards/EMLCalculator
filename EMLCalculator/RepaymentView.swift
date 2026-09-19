//
//  RepaymentView.swift
//  EMLCalculator
//
//  Created by Nathan McCrina on 9/19/26.
//

import SwiftData
import SwiftUI

struct RepaymentView : View {
    @Environment(\.modelContext) private var context
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.dismiss) private var dismiss
    @State private var selectedDate: Date = Date()
    @State private var memo: String = ""
    @State private var amount: Int = 0
    
    @Query() private var settings: [AppSettings]
    
    @ViewBuilder
    var body: some View {
        VStack {
            Form {
                TextField("Amount \(Currency.getConfiguredSymbol(settings: settings))", value: $amount, format: .number)
                DatePicker("Repayment Date", selection: $selectedDate, displayedComponents: [.date])
                TextField("Memo", text: $memo)
            }
        }
        .onAppear {
            amount = navigationContext.repaymentContext!.initialAmount
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Repayment from \(navigationContext.repaymentContext?.account.name ?? "")")
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    let newTransaction = Transaction(amount: amount * -1, account: navigationContext.repaymentContext!.account, date: selectedDate, memo: memo)
                    context.insert(newTransaction)
                    navigationContext.repaymentContext = nil
                    dismiss()
                }
            }
        }
    }
}
