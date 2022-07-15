//
//  Order.swift
//  CupcakeCorner
//
//  Created by Scott Gurney on 15/07/2022.
//

import Foundation

class OrderItem: ObservableObject {
    @Published var order = Order()
    
    enum CodingKeys: CodingKey {
        case order
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(order, forKey: .order)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        order = try container.decode(Order.self, forKey: .order)
    }
    
    init() { }

}
