//
//  ContentView.swift
//  WordScramble
//
//  Created by Scott Gurney on 03/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var newWord = ""
    @State private var rootWord = ""
    
    @State private var score = 0
    @State private var maxScore = 0
    
    @State private var showingError = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                    HStack {
                        Text("Score: \(score)")
                        Spacer()
                        Text("High Score: \(maxScore)")
                    }
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button("New Game", action: startGame)
                
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }

    
    func addNewWord() {
        // Lowercase newWord and remove any whitespace
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Check that it has at least 1 character otherwise exit
        guard checkLength(word: answer) else {
            wordError(title: "Word is too short", message: "Try another word at least 3 characters long")
            return
        }
        
        // Check word is not rootWord
        guard notStartWord(word: answer) else {
            wordError(title: "Word is root word", message: "You cannot simply use the starting word")
            return
        }
        
        // Check word is acceptable
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognised", message: "You cannot just make words up")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell '\(answer)' from '\(rootWord)'!")
            return
        }
        
        // Insert that word at position 0 in the usedWords array
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        // Update score
        score += calculateScore(word: answer)
        
        // Update high score
        if checkHighScore(score: score) {
            maxScore = score
        }
        
        // Set newWord back to be an empty string
        newWord = ""
    }
    
    func startGame() {
        // Find start.txt in our bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // Load it into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // Split that string into array of strings, with each element being one word
                let allWords = startWords.components(separatedBy: "\n")
                
                // Pick one random word from there to be assigned to rootWord, or use a sensible default if the array is empty.
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords = [String]()
                score = 0
                
                return
            }
        }
        
        fatalError("Could not load 'start.txt' from bundle")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        // Loop over each letter in word
        for letter in word {
            // Check if letter is in tempWord, if true assign index to pos
            if let pos = tempWord.firstIndex(of: letter) {
                // If true remove element in tempWord at pos
                tempWord.remove(at: pos)
            } else {
                // Else false
                return false
            }
        }
        
        // If hear all letters were in tempWord so return ture
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return mispelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func checkLength(word: String) -> Bool {
        word.count >= 3
    }
    
    func notStartWord(word: String) -> Bool {
        word != rootWord
    }
    
    func calculateScore(word: String) -> Int {
        if word.count == 8 {
            return 10
        } else {
            return word.count
        }
    }
    
    func checkHighScore(score: Int) -> Bool {
        score > maxScore
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
