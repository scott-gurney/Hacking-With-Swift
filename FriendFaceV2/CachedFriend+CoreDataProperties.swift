//
//  CachedFriend+CoreDataProperties.swift
//  FriendFaceV2
//
//  Created by Scott Gurney on 22/07/2022.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?
    
    var wrappedName: String {
        name ?? ""
    }

}

extension CachedFriend : Identifiable {

}
