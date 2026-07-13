//
//  Expense.swift
//  Personal-Expennse-Tracker
//
//  Created by Felix B Susanto on 13/7/2026.
//

import Foundation

struct Expense: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var amount: Double
    var date: Date

    init(id: UUID = UUID(), title: String, amount: Double, date: Date) {
        self.id = id
        self.title = title
        self.amount = amount
        self.date = date
    }
}
