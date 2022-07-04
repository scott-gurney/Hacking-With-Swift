//
//  ContentView.swift
//  TryingTimes
//
//  Created by Scott Gurney on 04/07/2022.
//


import SwiftUI

struct ContentView: View {
    @State private var timeTable = 5
    @State private var choiceOfQuestions = [5, 10, 20]
    @State private var numberOfQuestions = 10
    
    @State private var question = Int.random(in: 1...12)
    @State private var answer = ""
    
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            Text("What times table would you like to practice?")
            Picker("Select your times table", selection: $timeTable) {
                ForEach(2..<13) {
                    Text($0, format: .number)
                }
            }
            .pickerStyle(.segmented)
            
            Text("How many questions?")
            Picker("Select your amount of questions", selection: $numberOfQuestions) {
                ForEach(choiceOfQuestions, id: \.self) { value in
                    Text(value, format: .number)
                }
            }
            .pickerStyle(.segmented)
            
            Text("\(question) x \(timeTable + 2)")
            TextField("Enter your answer here", text: $answer)
                .keyboardType(.numberPad)
        }
        .onSubmit {
            showingAlert = checkAnswer(answer: Int(answer) ?? 0)
        }
        .alert("Alert", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message : {
            Text("Message")
        }
    }
    
    func checkAnswer(answer: Int) -> Bool {
        let correctAnswer = question * (timeTable + 2)
        
        return correctAnswer == answer
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
