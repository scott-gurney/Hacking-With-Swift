//
//  ContentView.swift
//  Bug
//
//  Created by Scott Gurney on 03/08/2022.
//

import SwiftUI

struct ContentView: View {
    private var usedWords = ["a", "ab", "abc", "abcd", "abcde", "abcdef", "abcdefg", "abcdefgh"]
    
    var body: some View {
        Section {
            ForEach(usedWords, id: \.self) { word in
                HStack {
                    Image(systemName: "\(word.count).circle.fill")
                    Text(word)
                }
                .accessibilityElement()
                .accessibilityLabel(word)
                .accessibilityHint("\(word.count) letters")
                .accessibilityAddTraits(.isStaticText)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
