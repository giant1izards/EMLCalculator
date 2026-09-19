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
    
    init(selectedAccount: Account? = nil) {
        self.selectedAccount = selectedAccount
        self.showAccountEditorView = false
        self.showTransactionEditorView = false
        self.showAccountSelectionView = false
    }
}
