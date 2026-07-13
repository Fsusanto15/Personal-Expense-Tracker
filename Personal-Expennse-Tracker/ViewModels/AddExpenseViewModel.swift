//
//  AddExpenseViewModel.swift
//  Personal-Expennse-Tracker
//
//  Created by Felix B Susanto on 13/7/2026.
//

import Foundation
internal import Combine

@MainActor
final class AddExpenseViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var amountText: String = ""
    @Published var date: Date = .now
    @Published private(set) var validationError: String?

    private let repository: ExpenseRepository
    private let onSave: (Expense) -> Void

    init(repository: ExpenseRepository, onSave: @escaping (Expense) -> Void) {
        self.repository = repository
        self.onSave = onSave
    }

    var isValid: Bool {
        validate() == nil
    }

    func save() -> Bool {
        guard let amount = parsedAmount(), validate() == nil else {
            validationError = validate()
            return false
        }
        let expense = Expense(
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            amount: amount,
            date: date
        )
        onSave(expense)
        return true
    }

    private func parsedAmount() -> Double? {
        Double(amountText)
    }

    private func validate() -> String? {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedTitle.isEmpty {
            return "Title can't be empty."
        }
        guard let amount = parsedAmount() else {
            return "Amount must be a valid number."
        }
        if amount <= 0 {
            return "Amount must be greater than zero."
        }
        return nil
    }
}
