//
//  Location.swift
//  BucketListApp
//
//  Created by Scott Gurney on 30/07/2022.
//

import Foundation

struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
}
