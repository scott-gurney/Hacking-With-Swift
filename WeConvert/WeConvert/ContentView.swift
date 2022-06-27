//
//  ContentView.swift
//  WeConvert
//
//  Created by Scott Gurney on 27/06/2022
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = 0.0
    @State private var unitFrom = "mm"
    @State private var unitTo = "cm"
    @FocusState private var amountIsFocused: Bool
    
    let units = ["mm", "cm", "m", "km", "in", "ft", "yd", "mi"]
    
    var inoutToMillimeters: Double {
        switch unitFrom {
        case "km":
            return inputValue * 1000000
        case "m":
            return inputValue * 1000
        case "cm":
            return inputValue * 10
        case "in":
            return inputValue * 25.4
        case "ft":
            return inputValue * 304.8
        case "yd":
            return inputValue * 914.4
        case "mi":
            return inputValue * 1609344
        default:
            return inputValue
        }
    }
    
    var convertCalculation: Double {
        switch unitTo {
        case "km":
            return inoutToMillimeters / 1000000
        case "m":
            return inoutToMillimeters / 1000
        case "cm":
            return inoutToMillimeters / 10
        case "in":
            return inoutToMillimeters / 25.4
        case "ft":
            return inoutToMillimeters / 304.8
        case "yd":
            return inoutToMillimeters / 914.4
        case "mi":
            return inoutToMillimeters / 1609344
        default:
            return inoutToMillimeters
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Unit to convert", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Input value to convert")
                }
                
                Section {
                    Picker("Units", selection: $unitFrom) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select unit to convert from")
                }

                
                Section {
                    Picker("Units", selection: $unitTo) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select unit to convert to")
                }
                
                Section {
                    Text("\(convertCalculation.formatted())\(unitTo)")
                } header: {
                    Text("Converted value")
                }

            }
            .navigationTitle("WeConvert")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
