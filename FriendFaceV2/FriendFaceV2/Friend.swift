//
//  Friend.swift
//  FriendFaceV2
//
//  Created by Scott Gurney on 22/07/2022.
//

import Foundation

struct Friend: Identifiable, Codable {
    let id: UUID
    let name: String
}
