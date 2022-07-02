//
//  ContentView.swift
//  BrainTrain
//
//  Created by Scott Gurney on 01/07/2022.
//

import SwiftUI

struct ContentView: View {
    private let handGestures = ["👊", "✋", "✌️"]
    @State private var phoneChoice = Int.random(in: 0...2)
    @State private var playType = Bool.random()
    @State private var score = 0
    @State private var maxScore = -10
    @State private var gameCount = 0
    @State private var showingAlert = false
    
    func checkResult(_ number: Int) {
        gameCount += 1
        
        if(playType) {
            if(number == numberOusideArray(phoneChoice + 1))
            {
                score += 1
            }
            else {
                score -= 1
            }
        } else {
            if(number == numberOusideArray(phoneChoice - 1)) {
                score += 1
            }
            else {
                score -= 1
            }
        }
        
        if(gameCount == 10) {
            showingAlert = true
            if(score > maxScore)
            {
                maxScore = score
            }
        }
        
        phoneChoice = Int.random(in: 0...2)
        playType.toggle()
        
    }
    
    func numberOusideArray(_ number: Int) -> Int {
        if(number >= handGestures.count) {
            return 0
        }
        else if(number < 0) {
            return handGestures.count - 1
        }
        else {
            return number
        }
    }
    
    func reset() {
        phoneChoice = Int.random(in: 0...2)
        playType.toggle()
        score = 0
        gameCount = 0
    }
    
    private var type: String {
        if(playType) {
            return "✅ ✅  Win  ✅ ✅"
        } else {
            return "❌ ❌  Lose  ❌ ❌"
        }
    }
    
    var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.indigo, .blue, .indigo]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    VStack(alignment: .leading) {
                        Text("Brain Train")
                            .font(.largeTitle)
                        Text("Win or Lose as instructed against your phone")
                    }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    VStack {
                        Text(handGestures[phoneChoice])
                            .font(.system(size: 100))
                    }
                    
                    
                    Spacer()
                    
                    VStack {
                        Text(type)
                            .font(.largeTitle.bold())
                    }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Spacer()
                    
                    HStack {
                        ForEach(0..<3) { gesture in
                            Button {
                                checkResult(gesture)
                            } label: {
                                Text(handGestures[gesture])
                                    .font(.system(size: 60))
                                    .padding()
                                    .shadow(color: .white, radius: 15)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Current Score: \(score)")
                        Text("Best Score: \(maxScore)")
                    }
                        .font(.title)
                    
                    Spacer()
                    
                }
                .foregroundColor(.white)
                .padding()
                
            }
        
            .alert("Game Over", isPresented: $showingAlert) {
                Button("New Game", action: reset)
            } message: {
                Text("Your score is \(score)")
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
