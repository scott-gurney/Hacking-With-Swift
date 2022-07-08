//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Scott Gurney on 08/07/2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
