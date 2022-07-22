//
//  FriendFaceV2App.swift
//  FriendFaceV2
//
//  Created by Scott Gurney on 22/07/2022.
//

import SwiftUI

@main
struct FriendFaceV2App: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
