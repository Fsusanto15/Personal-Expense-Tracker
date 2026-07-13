//
//  F.swift
//  Personal-Expennse-Tracker
//
//  Created by Felix B Susanto on 13/7/2026.
//

import Foundation

class FileExpenseRepository: ExpenseRepository {
    private let fileURL: URL

    init(fileName: String = "expenses.json") {
        let documentsDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
        self.fileURL = documentsDirectory.appendingPathComponent(fileName)
    }

    func load() throws -> [Expense] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return []
        }
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode([Expense].self, from: data)
    }

    func save(_ expenses: [Expense]) throws {
        let data = try JSONEncoder().encode(expenses)
        try data.write(to: fileURL, options: .atomic)
    }
}
