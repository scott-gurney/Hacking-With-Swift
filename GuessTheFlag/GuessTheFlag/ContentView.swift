//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Scott Gurney on 27/06/2022.
//

import SwiftUI

struct FlagImage: View {
    var flags: [String]
    var number: Int
    
    var body: some View {
        Image(flags[number])
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var endOfGame = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameNumber = 0
    
    @State private var rotationDegrees = [0.0, 0.0, 0.0]
    @State private var opacityLevel = [1.0, 1.0, 1.0]
    @State private var correctFlag = [false, false, false]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
                     ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation() {
                                flagTapped(number)
                                rotationDegrees[number] = 360.0
                                opacityLevel[number == 0 ? 1: number == 1 ? 2: 0] = 1.75
                                opacityLevel[number == 0 ? 2: number == 1 ? 0: 1] = 1.75
                                opacityLevel[number == correctAnswer ? number : correctAnswer] = 0.0
                                correctFlag[number == correctAnswer ? number : correctAnswer] = true
                            }
                        } label: {
                            FlagImage(flags: countries, number: number)
                        }
                        .rotation3DEffect(.degrees(rotationDegrees[number]), axis: (x: 0, y: 1, z: 0))
                        .opacity(2 - opacityLevel[number])
                        .scaleEffect(correctFlag[number] ? 1.5 : 1)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
                
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }
        
        .alert("Game Over", isPresented: $endOfGame) {
            Button("OK", action: reset)
            Button("Cancel", role: .cancel) { }
            } message: {
                    Text("Your score was \(score), play again?")
            }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        }
        else {
            scoreTitle = "Wrong, that is \(countries[number])s flag"
        }
                
        if gameNumber < 7 {
            showingScore = true
        }
        else {
            showingScore = true
            endOfGame = true
        }
        
        gameNumber += 1
    }
    
    func askQuestion() {
        withAnimation {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            opacityLevel = [1.0, 1.0, 1.0]
            correctFlag = [false, false, false]
        }
        rotationDegrees = [0.0, 0.0, 0.0]
    }
    
    func reset() {
        askQuestion()
        gameNumber = 0
        score = 0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
