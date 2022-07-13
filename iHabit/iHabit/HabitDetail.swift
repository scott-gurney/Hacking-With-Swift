//
//  HabitDetail.swift
//  iHabit
//
//  Created by Scott Gurney on 13/07/2022.
//

import SwiftUI

struct ButtonStyle: View {
    let text: String
    let green: Bool
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .frame(width: 150, height: 150)
            .background(green ? .green : .red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
    }
}

struct HabitDetail: View {
    var habit: HabitItem
    @ObservedObject var habits: Habits
            
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("\(habit.name)")
                    .font(.largeTitle)
                
                Text("\(habit.description)")
                    .font(.title)
                                
                Text("Streak: \(habit.value)")
                    .font(.largeTitle)
            }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Button {
                    increaseAmount()
                } label: {
                    ButtonStyle(text: "Plus", green: true)
                }
                
                Button {
                    resetAmount()
                } label: {
                    ButtonStyle(text: "Reset", green: false)
                }
            }
            
            Spacer()
            
        }
    }
    
    func increaseAmount() {
        var temp = habit.value
        temp += 1
        
        let index = habits.items.firstIndex(of: habit)
        
        habits.items[index ?? 0].value = temp
    }
    
    func resetAmount() {
        let index = habits.items.firstIndex(of: habit)
        
        habits.items[index ?? 0].value = 0
    }
}

struct HabitDetail_Previews: PreviewProvider {
    static let habits = [HabitItem(name: "Test 1", description: "Desc", value: 0)]
    
    static var previews: some View {
        HabitDetail(habit: habits[0], habits: Habits())
    }
}
