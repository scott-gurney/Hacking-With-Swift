//
//  Friend.swift
//  FriendFace
//
//  Created by Scott Gurney on 19/07/2022.
//

import Foundation

struct Friend: Identifiable, Codable {
    let id: UUID
    let name: String
}
