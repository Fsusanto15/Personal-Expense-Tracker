//
//  AddExpenseView.swift
//  Personal-Expennse-Tracker
//
//  Created by Felix B Susanto on 14/7/2026.
//


import SwiftUI

struct AddExpenseView: View {
    @ObservedObject var viewModel: AddExpenseViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Form {
            Section("Details") {
                TextField("Title", text: $viewModel.title)
                TextField("Amount", text: $viewModel.amountText)
                    .keyboardType(.decimalPad)
                DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
            }

            if let error = viewModel.validationError {
                Section {
                    Text(error)
                        .foregroundStyle(.red)
                        .font(.callout)
                }
            }
        }
        .navigationTitle("Add Expense")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    if viewModel.save() {
                        dismiss()
                    }
                }
                .disabled(!viewModel.isValid)
            }
        }
    }
}


/// PREVIEW
#Preview {
    NavigationStack {
        AddExpenseView(
            viewModel: AddExpenseViewModel(
                repository: PreviewExpenseRepository(),
                onSave: { expense in
                    print("Preview save: \(expense.title)")
                }
            )
        )
    }
}

private struct PreviewExpenseRepository: ExpenseRepository {
    func load() throws -> [Expense] { [] }
    func save(_ expenses: [Expense]) throws { }
}
