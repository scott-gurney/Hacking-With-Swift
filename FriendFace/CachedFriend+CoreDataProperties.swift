//
//  CachedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Scott Gurney on 21/07/2022.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var user: CachedUser?
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }

}

extension CachedFriend : Identifiable {

}
