//
//  ContentView.swift
//  iExpense
//
//  Created by Scott Gurney on 08/07/2022.
//

import SwiftUI

//struct AmountText: View {
//    var amount: Double
//
//    var body: some View {
//        if(amount < 10.0) {
//            Text(amount, format: .localCurrency)
//                .frame(width: 100, height: 50)
//                .background(.green)
//                .foregroundColor(.white)
//                .clipShape(Capsule())
//        } else if (amount >= 10 && amount < 100) {
//            Text(amount, format: .localCurrency)
//                .frame(width: 100, height: 50)
//                .background(.yellow)
//                .clipShape(Capsule())
//        } else {
//            Text(amount, format: .localCurrency)
//                .frame(width: 100, height: 50)
//                .foregroundColor(.white)
//                .background(.red)
//                .clipShape(Capsule())
//        }
//    }
//}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @StateObject var businessExpenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ExpenseSection(title: "Business", expenses: expenses.businessItems, deleteItems: removeBusinessItems)
                
                ExpenseSection(title: "Personal", expenses: expenses.personalItems, deleteItems: removeBusinessItems)
            }
            .navigationBarTitle("iExpense")
            
            .toolbar {
                Button {
//                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
//                    expenses.items.append(expense)
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses, businessExpenses: businessExpenses)
            }

        }
    }
    
    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
        var objectToDelete = IndexSet()
        
        for offset in offsets {
            let item = inputArray[offset]
            
            if let index = expenses.items.firstIndex(of: item) {
                objectToDelete.insert(index)
            }
        }
        
        expenses.items.remove(atOffsets: offsets)
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.personalItems)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.businessItems)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
