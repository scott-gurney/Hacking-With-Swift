//
//  HabitDetail.swift
//  iHabit
//
//  Created by Scott Gurney on 13/07/2022.
//

import SwiftUI

struct HabitDetail: View {
    var habit: HabitItem
        
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Description:")
                    .font(.title)
                Text("\(habit.description)")
                
                Spacer()
                
//                Stepper("Days", value: habit.value)
//                Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("\(habit.name)")
        }
    }
}

struct HabitDetail_Previews: PreviewProvider {
    static let habits = [HabitItem(name: "Test 1", description: "Desc", value: 0)]
    
    static var previews: some View {
        HabitDetail(habit: habits[0])
    }
}
