//
//  AddHabit.swift
//  iHabit
//
//  Created by Scott Gurney on 13/07/2022.
//

import SwiftUI

struct AddHabit: View {
    @State private var name = ""
    @State private var description = ""
    @State private var amount = 0
    
    @ObservedObject var habits: Habits
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
                Stepper(amount == 1 ? "1 Day" : "\(amount) Days", value: $amount)
            }
            .navigationTitle("Add new habit")
            .toolbar {
                Button("Save") {
                    let habit = HabitItem(name: name, description: description, value: amount)
                    habits.items.insert(habit, at: 0)
                    dismiss()
                }
            }
        }
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit(habits: Habits())
    }
}
