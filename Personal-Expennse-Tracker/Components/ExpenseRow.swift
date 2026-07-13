//
//  ExpenseRow.swift
//  Personal-Expennse-Tracker
//
//  Created by Felix B Susanto on 14/7/2026.
//

import SwiftUI

struct ExpenseRow: View {
    let expense: Expense
    private var formattedAmount: String {
        expense.amount.formatted(.currency(code: Locale.current.currency?.identifier ?? "MYR"))
    }
    private var formattedDate: String {
        expense.date.formatted(date: .abbreviated, time: .omitted)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.title)
                    .font(.body)
                Text(formattedDate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(formattedAmount)
                .font(.body.monospacedDigit())
        }
        .padding(.vertical, 4)
    }
}
