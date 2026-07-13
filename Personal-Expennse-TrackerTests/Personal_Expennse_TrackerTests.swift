//
//  Personal_Expennse_TrackerTests.swift
//  Personal-Expennse-TrackerTests
//
//  Created by Felix B Susanto on 13/7/2026.
//

import Testing
import XCTest
@testable import Personal_Expennse_Tracker

final class FileExpenseRepositoryTests: XCTestCase {
    func test_saveThenLoad_returnsSameExpenses() throws {
        let repository = FileExpenseRepository(fileName: "test_expenses.json")
        let expenses = [
            Expense(title: "Coffee", amount: 4.5, date: .now)
        ]

        try repository.save(expenses)
        let loaded = try repository.load()

        XCTAssertEqual(loaded, expenses)
    }

    func test_load_whenNoFileExists_returnsEmptyArray() throws {
        let repository = FileExpenseRepository(fileName: "nonexistent_\(UUID()).json")
        let loaded = try repository.load()
        XCTAssertEqual(loaded, [])
    }
}

struct Personal_Expennse_TrackerTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

}
