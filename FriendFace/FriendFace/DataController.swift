//
//  DataController.swift
//  FriendFace
//
//  Created by Scott Gurney on 21/07/2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Friendface")

    init() {
        container.loadPersistentStores { descriptoin, error in
            if let error = error {
                print("Core Date failed to load: \(error.localizedDescription)")
            }
        }
        
        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
}
