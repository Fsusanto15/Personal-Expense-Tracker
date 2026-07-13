//
//  ExpenseListView.swift
//  Personal-Expennse-Tracker
//
//  Created by Felix B Susanto on 14/7/2026.
//

import SwiftUI

struct ExpenseListView: View {
    @StateObject private var viewModel: ExpenseListViewModel
    @State private var isShowingAddExpense = false

    private let repository: ExpenseRepository

    init(repository: ExpenseRepository) {
        self.repository = repository
        _viewModel = StateObject(wrappedValue: ExpenseListViewModel(repository: repository))
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Expenses")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isShowingAddExpense = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .navigationDestination(isPresented: $isShowingAddExpense) {
                    AddExpenseView(
                        viewModel: AddExpenseViewModel(
                            repository: repository,
                            onSave: { expense in
                                viewModel.addExpense(expense)
                            }
                        )
                    )
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView("Loading expenses…")

        case .loaded(let expenses) where expenses.isEmpty:
            ContentUnavailableView(
                "No Expenses Yet",
                systemImage: "tray",
                description: Text("Tap + to add your first expense.")
            )

        case .loaded(let expenses):
            List {
                ForEach(expenses) { expense in
                    ExpenseRow(expense: expense)
                }
                .onDelete { offsets in // to swipe delete
                    viewModel.deleteExpense(at: offsets)
                }
            }
            .safeAreaInset(edge: .bottom) {
                    HStack {
                        Text("Total")
                            .font(.headline)
                        Spacer()
                        Text(viewModel.totalAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))
                            .font(.headline.monospacedDigit())
                    }
                    .padding()
                    .background(.bar)
                }

        case .error(let message):
            VStack(spacing: 12) {
                Text(message)
                    .multilineTextAlignment(.center)
                Button("Retry") {
                    viewModel.load()
                }
            }
            .padding()
        }
    }
}

/// PREVIEW
#Preview("With Expenses") {
    ExpenseListView(repository: PreviewExpenseRepository(expenses: [
        Expense(title: "Coffee", amount: 4.50, date: .now),
        Expense(title: "Groceries", amount: 62.30, date: .now),
        Expense(title: "Train ticket", amount: 12.00, date: .now)
    ]))
}

private struct PreviewExpenseRepository: ExpenseRepository {
    let expenses: [Expense]

    func load() throws -> [Expense] { expenses }
    func save(_ expenses: [Expense]) throws { }
}
