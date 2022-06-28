//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Scott Gurney on 27/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("1")
                Spacer()
                Text("2")
                Spacer()
                Text("3")
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                Text("4")
                Spacer()
                Text("5")
                Spacer()
                Text("6")
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                Text("7")
                Spacer()
                Text("8")
                Spacer()
                Text("9")
                Spacer()
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
