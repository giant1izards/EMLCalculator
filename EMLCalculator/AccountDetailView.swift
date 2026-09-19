//
//  AccountDetailView.swift
//  EMLCalculator
//
//  Created by Nathan McCrina on 9/18/26.
//

import SwiftData
import SwiftUI

struct AccountDetailView : View {
    var account: Account?
    @Environment(\.modelContext) private var context
    
    @Environment(NavigationContext.self) private var navigationContext
    
    var body: some View {
        if let account {
            AccountView(account: account)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(account.name)
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Button("Edit", systemImage: "pencil") {
                            navigationContext.showAccountEditorView = true
                        }
                    }
                    
                    ToolbarItem(placement: .destructiveAction) {
                        Button("Delete", systemImage: "trash") {
                            navigationContext.selectedAccount = nil
                            context.delete(account)
                        }
                    }
                }
        }
        else {
            Text("Select an account")
        }
    }
}
