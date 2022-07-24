//
//  AddView.swift
//  iExpense
//
//  Created by Scott Gurney on 08/07/2022.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Personal", "Business"]
    
    @ObservedObject var expenses: Expenses
    @ObservedObject var businessExpenses: Expenses
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                
                TextField("Amount", value: $amount, format: .localCurrency)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            
            .toolbar {
                Button("Save") {
                    let expense = ExpenseItem(name: name, type: type, amount: amount)
                    
                    if(expense.type == "Personal") {
                        expenses.items.append(expense)
                    }
                    else {
                        businessExpenses.items.append(expense)
                    }
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses(), businessExpenses: Expenses())
    }
}
