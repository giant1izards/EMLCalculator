//
//  NewAccountEditorView.swift
//  EMLCalculator
//
//  Created by Nathan McCrina on 9/18/26.
//

import SwiftData
import SwiftUI

struct AccountEditorView : View {
    @Binding var account: Account?
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var context
    @State private var accountName = ""
    
    var body: some View {
        NavigationStack {
            Form {
                    TextField("Account name", text: $accountName)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let account {
                            account.name = accountName
                        }
                        else {
                            let newAccount = Account(name: accountName)
                            
                            context.insert(newAccount)
                        }
                        dismiss()
                    }
                    .disabled(accountName.isEmpty)
                }
            }
            .onAppear {
                if let account {
                    accountName = account.name
                }
            }
        }
    }
    
    private func dismiss() {
        navigationContext.showAccountEditorView = false
    }
}
