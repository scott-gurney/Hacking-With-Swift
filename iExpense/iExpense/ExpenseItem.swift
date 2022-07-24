//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Scott Gurney on 08/07/2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
