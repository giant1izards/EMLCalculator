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
    @State private var isRepayment: Bool = false
    
    @Query(sort: \Account.name) private var accounts: [Account]
    
    @ViewBuilder
    var body: some View {
        VStack {
            Form {
                TextField("Expense", value: $expense, format: .number)
                DatePicker("Expense Date", selection: $selectedDate)
                TextField("Memo", text: $expenseMemo)
                HStack {
                    Toggle(isOn: $includeSelf) {
                        Text("Include self")
                    }
                    Toggle(isOn: $isRepayment) {
                        Text("Repayment")
                    }
                }
            }
            
            List(accounts, id: \.self, selection: $selectedAccounts) { account in
                Text(selectedAccounts.isEmpty || !selectedAccounts.contains(where: { selectedAccount in
                    selectedAccount.name == account.name
                }) ? account.name : "\(account.name): \(getAmountOwed())")
            }
        }
        .toolbar {
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
        let includeSelfFactor = (includeSelf && !isRepayment) ? 1 : 0
        return (expense / (selectedAccounts.count + includeSelfFactor)) * (isRepayment ? -1 : 1)
    }
}
