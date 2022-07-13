//
//  ContentView.swift
//  iHabit
//
//  Created by Scott Gurney on 13/07/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    
    @State private var showingAddHabit = false
        
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items) { habit in
                    NavigationLink {
                        HabitDetail(habit: habit.self, habits: habits)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Name: \(habit.name)")
                                Text("Description: \(habit.description)")
                            }
                        }
                        
                        Spacer()
                        
                        Text("Streak: \(habit.value)")
                        
                    }
                    .foregroundColor(.black)
                    .padding(.vertical)
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("iHabit")
            .toolbar {
                Button {
                    showingAddHabit = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            .sheet(isPresented: $showingAddHabit) {
                AddHabit(habits: habits)
            }
        }
    }
    
    func removeItem(at offset: IndexSet) {
        habits.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
