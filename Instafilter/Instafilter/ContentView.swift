//
//  ContentView.swift
//  Instafilter
//
//  Created by Scott Gurney on 27/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filerIntensity = 0.5
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filerIntensity)
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter") {
                        
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
        }
    }
    
    func save() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
