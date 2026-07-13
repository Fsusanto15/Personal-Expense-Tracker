//
//  ExpenseListViewModel.swift
//  Personal-Expennse-Tracker
//
//  Created by Felix B Susanto on 13/7/2026.
//

import Foundation
import SwiftUI
internal import Combine

enum ExpenseListState {
    case loading
    case loaded([Expense])
    case error(String)
}

@MainActor
final class ExpenseListViewModel: ObservableObject {
    @Published private(set) var state: ExpenseListState = .loading

    private let repository: ExpenseRepository

    init(repository: ExpenseRepository) {
        self.repository = repository
        load()
    }
    
    var totalAmount: Double {
        guard case .loaded(let expenses) = state else { return 0 }
        
        var totalAmount = 0.0
        for expense in expenses {
            totalAmount += expense.amount
        }
        return totalAmount
    }

    func load() {
        state = .loading
        do {
            let expenses = try repository.load()
            state = .loaded(expenses)
        } catch {
            state = .error("Couldn't load your expenses. \(error.localizedDescription)")
        }
    }

    func addExpense(_ expense: Expense) {
        guard case .loaded(var expenses) = state else {
            var expenses: [Expense] = []
            expenses.append(expense)
            persist(expenses)
            return
        }
        expenses.append(expense)
        persist(expenses)
    }

    func deleteExpense(at offsets: IndexSet) {
        guard case .loaded(var expenses) = state else { return }
        expenses.remove(atOffsets: offsets)
        persist(expenses)
    }

    private func persist(_ expenses: [Expense]) {
        do {
            try repository.save(expenses)
            state = .loaded(expenses)
        } catch {
            state = .error("Couldn't save your changes. \(error.localizedDescription)")
        }
    }
}
