//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Scott Gurney on 15/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State var orderItem = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your type", selection: $orderItem.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cupcakes: \(orderItem.quantity)", value: $orderItem.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $orderItem.specialRequestEnabeled.animation())
                    
                    if orderItem.specialRequestEnabeled {
                        Toggle("Add extra frosting", isOn: $orderItem.extraFrosting)
                        
                        Toggle("Add extra sprinkles", isOn: $orderItem.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(orderItem: orderItem)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
