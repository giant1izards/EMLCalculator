//
//  TransactionView.swift
//  EMLCalculator
//
//  Created by Nathan McCrina on 9/18/26.
//

import SwiftData
import SwiftUI

struct TransactionView : View {
    @Environment(\.modelContext) private var context
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.dismiss) private var dismiss
    @State private var selectedAccounts: Set<Account> = Set<Account>()
    @State private var selectedDate: Date = Date()
    @State private var expenseMemo: String = ""
    @State private var expense: Int = 0
    @State private var isSelectingAccount: Bool = false
    @State private var includeSelf: Bool = true
    
    @Query(sort: \Account.name) private var accounts: [Account]
    @Query() private var settings: [AppSettings]
    
    @ViewBuilder
    var body: some View {
        VStack {
            Form {
                TextField("Expense \(Currency.getConfiguredSymbol(settings: settings))", value: $expense, format: .number)
                DatePicker("Expense Date", selection: $selectedDate, displayedComponents: [.date])
                TextField("Memo", text: $expenseMemo)
                HStack {
                    Toggle(isOn: $includeSelf) {
                        Text("Include self")
                    }
                }
            }
            .frame(minHeight: 400)
            
            List(accounts, id: \.self, selection: $selectedAccounts) { account in
                Text(selectedAccounts.isEmpty || !selectedAccounts.contains(where: { selectedAccount in
                    selectedAccount.name == account.name
                }) ? account.name : "\(account.name): \(getAmountOwed())")
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Record Expense")
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                        for account in selectedAccounts {
                            let newTransaction = Transaction(amount: getAmountOwed(), account: account, date: selectedDate, memo: expenseMemo)
                            context.insert(newTransaction)
                        }
                    dismiss()
                }
            }
        }
    }
    
    private func getAmountOwed() -> Int {
        let includeSelfFactor = includeSelf ? 1 : 0
        return expense / (selectedAccounts.count + includeSelfFactor)
    }
}
