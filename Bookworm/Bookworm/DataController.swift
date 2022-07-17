//
//  DataController.swift
//  Bookworm
//
//  Created by Scott Gurney on 17/07/2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")

    init() {
        container.loadPersistentStores { descriptoin, error in
            if let error = error {
                print("Core Date failed to load: \(error.localizedDescription)")
            }
        }
    }
}
