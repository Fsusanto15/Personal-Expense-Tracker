//
//  FileExpenseRepository.swift
//  Personal-Expennse-Tracker
//
//  Created by Felix B Susanto on 13/7/2026.
//

import Foundation

protocol ExpenseRepository {
    func load() throws -> [Expense]
    func save(_ expenses: [Expense]) throws
}
