//
//  ContentView.swift
//  Drawing
//
//  Created by Scott Gurney on 12/07/2022.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.maxX * 0.25, y: rect.maxY * 0.25))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.75, y: rect.maxY * 0.25))
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        return path
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var insetAmount = 0.0
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                RoundedRectangle(cornerRadius: CGFloat(110))
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            colors: [color(for: value, brightness: 1),
                                     color(for: value, brightness: 0.5)],
                            startPoint: .top,
                            endPoint: .bottom),
                        lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var strokeWidth = 10.0
    @State private var colorCycle = 0.0
        
    var animatableData: Double {
        get { strokeWidth }
        set { strokeWidth = newValue }
    }
    
    var body: some View {
        VStack {
//            Arrow()
//                .stroke(.blue, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round))
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    withAnimation {
//                        strokeWidth = Double.random(in: 1...50)
//                    }
//                }
            
            ColorCyclingRectangle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
