//
//  ContentView.swift
//  iExpense
//
//  Created by Scott Gurney on 08/07/2022.
//

import SwiftUI

struct AmountText: View {
    var amount: Double

    var body: some View {
        if(amount < 10.0) {
            Text(amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                .frame(width: 100, height: 50)
                .background(.green)
                .foregroundColor(.white)
                .clipShape(Capsule())
        } else if (amount >= 10 && amount < 100) {
            Text(amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                .frame(width: 100, height: 50)
                .background(.yellow)
                .clipShape(Capsule())
        } else {
            Text(amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                .frame(width: 100, height: 50)
                .foregroundColor(.white)
                .background(.red)
                .clipShape(Capsule())
        }
    }
}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @StateObject var businessExpenses = Expenses()

    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section("Personal") {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        AmountText(amount: item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
                .headerProminence(.increased)
                
                Section("Business") {
                
                ForEach(businessExpenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        AmountText(amount: item.amount)
                    }
                }
                .onDelete(perform: removeBusinessItems)
                }
                .headerProminence(.increased)

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
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        businessExpenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
