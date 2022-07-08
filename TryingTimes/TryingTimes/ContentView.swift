//
//  ContentView.swift
//  TryingTimes
//
//  Created by Scott Gurney on 04/07/2022.
//


import SwiftUI

struct Question {
    let multiplierPosistion: Int
    var baseValue = Int.random(in: 1...12)
    
    var multiplier: Int {
        multiplierPosistion + 2
    }
    
    var answerArray: [Int] {
        var tempArray = [baseValue * multiplier]
        
        repeat {
            let tempNumber = Int.random(in: 1...12) * multiplier
            
            if(!tempArray.contains(tempNumber)) {
                tempArray.append(tempNumber)
            }
        } while tempArray.count != 4
        
        return tempArray.shuffled()
    }
    
    var answer: Int {
        baseValue * multiplier
    }
    
    func questionText() -> Text {
        Text("\(baseValue) x \(multiplier) = ??")
    }
    
    func checkAnswer(input: Int) -> Bool {
        input == answer
    }
    
}

struct ContentView: View {
    @State private var timeTablePosistion = 3
    @State private var choiceOfQuestions = [5, 10, 20]
    @State private var numberOfQuestions = 10
    @State private var currentQuestion = 1
    @State private var score = 0
    
//    @State private var question = Int.random(in: 1...12)
//    @State private var answer = ""
        
    @State private var showingAlert = false
    @State private var answerCorrect = false
    
    @State private var gameOver = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Spacer()
                Text("What times table would you like to practice?")
                Picker("Select your times table", selection: $timeTablePosistion) {
                    ForEach(2..<13) {
                        Text($0, format: .number)
                    }
                }
                .pickerStyle(.segmented)
                
                    Spacer()
                    
                Text("How many questions?")
                Picker("Select your amount of questions", selection: $numberOfQuestions) {
                    ForEach(choiceOfQuestions, id: \.self) { value in
                        Text(value, format: .number)
                    }
                }
                .pickerStyle(.segmented)
                
                Spacer()
            }
                Divider()
            VStack {
                Spacer()
                let testQuestion = Question(multiplierPosistion: timeTablePosistion)
                
                testQuestion.questionText()
                
//                Text("\(question) x \(timeTablePosistion + 2)")
                    .font(.largeTitle)
//                TextField("Enter your answer here", text: $answer)
//                    .keyboardType(.numberPad)
//
                Spacer()
                
                HStack {
                    ForEach(testQuestion.answerArray, id:\.self) { answer in
                        Button {
                            answerCorrect = testQuestion.checkAnswer(input: answer)
                            checkAnswer(answer: answerCorrect)
                        } label: {
                            Text("\(answer)")
                                .font(.largeTitle)
                                .frame(width: 75, height: 50, alignment: .center)
                                .background(.yellow)
                                .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                Spacer()
                Spacer()
            }
            }
            .navigationTitle("TryingTimes")
            .padding()
        }
        
//        .toolbar {
//            ToolbarItemGroup(placement: .keyboard) {
//                Spacer()
//
//                Button("Done") {
//                    answerCorrect = checkAnswer(answer: Int(answer) ?? 0)
//                }
//            }
//        }

//        .onSubmit() {
//            answerCorrect = checkAnswer(answer: Int(answer) ?? 0)
//        }
        .alert((answerCorrect ? "Correct" : "Wrong"), isPresented: $showingAlert) {
            Button("Next question", role: .cancel) {
                nextGuestion()
            }
        }
        .alert("Game Over!", isPresented: $gameOver) {
            Button("Play Again", role: .cancel, action: newGame)
            } message: {
                Text("Well Done, you got \(score) questions right out of \(numberOfQuestions)")
        }
        
    }
    
    func checkAnswer(answer: Bool) -> Bool {
        let correctAnswer = answer
        showingAlert.toggle()
        currentQuestion += 1
        
        if(correctAnswer) {
            score += 1
        }
        
        return correctAnswer
        
    }
    
    func nextGuestion() {
        if(currentQuestion > numberOfQuestions) {
            gameOver.toggle()
        }
        
//        question = Int.random(in: 1...12)
//        answer = ""
    }
    
    func newGame() {
//        question = Int.random(in: 1...12)
//        answer = ""
        score = 0
        currentQuestion = 1
        nextGuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
