//
//  HabitItem.swift
//  iHabit
//
//  Created by Scott Gurney on 13/07/2022.
//

import Foundation

struct HabitItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    var value: Int
}
