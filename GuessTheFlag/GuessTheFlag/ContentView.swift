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
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var endOfGame = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameNumber = 0
    
    @State private var selectedFlag = -1
    
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
                    .accessibilityHidden(true)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            
                    }
                    .accessibilityElement()
                    .accessibilityLabel("Tap the flag of \(countries[correctAnswer])")
                    
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation() {
                                flagTapped(number)
                            }
                        } label: {
                            FlagImage(flags: countries, number: number)
                        }
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                        .rotation3DEffect(.degrees(selectedFlag == number ? 360 : 0), axis: (x: 0, y: 1, z:0))
                        .opacity(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
                        .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
                        .animation(.default, value: selectedFlag)
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
        selectedFlag = number
        
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
            selectedFlag = -1
        }
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
