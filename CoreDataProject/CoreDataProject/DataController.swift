//
//  DataController.swift
//  CoreDataProject
//
//  Created by Scott Gurney on 19/07/2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")

    init() {
        container.loadPersistentStores { descriptoin, error in
            if let error = error {
                print("Core Date failed to load: \(error.localizedDescription)")
            }
        }
        
        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
}
