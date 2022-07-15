//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Scott Gurney on 15/07/2022.
//

import SwiftUI

struct AddressView: View {
    @State var orderItem: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderItem.name)
                TextField("Street address", text: $orderItem.streetAddress)
                TextField("City", text: $orderItem.city)
                TextField("Zip", text: $orderItem.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(orderItem: orderItem)
                } label: {
                    Text("Check out")
                }
                .disabled(orderItem.hasValidAddress == false)
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orderItem: Order())
    }
}
