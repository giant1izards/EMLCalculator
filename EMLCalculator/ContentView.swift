//
//  ContentView.swift
//  EMLCalculator
//
//  Created by Nathan McCrina on 9/18/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var accounts: [Account]
    @State private var navigationContext = NavigationContext()

    var body: some View {
        NavigationSplitView {
            List(selection: $navigationContext.selectedAccount) {
                ForEach(accounts) { account in
                    NavigationLink(account.name, value: account)
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: executeTransaction) {
                        Label("New Transaction", systemImage: "repeat")
                    }
                    .disabled(accounts.isEmpty)
                    .help("Record a new transaction")
                }

                ToolbarItem {
                    Button(action: addAccount) {
                        Label("Add Account", systemImage: "plus")
                    }
                    .help("Add a new account")
                }
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 250, ideal: 300)
#endif
        } detail: {
            NavigationStack {
                AccountDetailView(account: navigationContext.selectedAccount)
                .navigationDestination(isPresented: $navigationContext.showAccountEditorView) {
                    AccountEditorView(account: $navigationContext.selectedAccount)
                }
                .navigationDestination(isPresented: $navigationContext.showTransactionEditorView) {
                    TransactionView()
                }
            }
        }
        .environment(navigationContext)
    }
    
    private func executeTransaction() {
        navigationContext.showTransactionEditorView = true
    }

    private func addAccount() {
        navigationContext.showAccountEditorView = true
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(accounts[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Account.self, inMemory: true)
}
