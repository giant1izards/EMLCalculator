//
//  NavigationContext.swift
//  EMLCalculator
//
//  Created by Nathan McCrina on 9/18/26.
//

import SwiftUI

@Observable
class NavigationContext {
    var selectedAccount: Account?
    
    var showAccountEditorView: Bool
    var showTransactionEditorView: Bool
    var showAccountSelectionView: Bool
    var showRepaymentView: Bool
    var showSettingsView: Bool
    
    var repaymentContext: RepaymentContext?
    
    init(selectedAccount: Account? = nil) {
        self.selectedAccount = selectedAccount
        self.showAccountEditorView = false
        self.showTransactionEditorView = false
        self.showAccountSelectionView = false
        self.showRepaymentView = false
        self.showSettingsView = false
        self.repaymentContext = nil
    }
}
