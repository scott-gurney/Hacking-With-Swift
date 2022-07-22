//
//  ContentView.swift
//  FriendFace
//
//  Created by Scott Gurney on 19/07/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var users: FetchedResults<CachedUser>
    
//    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink //(destination: DetailView(user: user))
                    {
                        DetailView(user: user)
                } label: {
                    HStack {
                        ActiveView(isActive: user.isActive)
                            .padding(.trailing)
                    
                        VStack(alignment: .leading) {
                            Text(user.wrappedName)
                                .font(.headline)
                            Text(user.wrappedCompany)
                        }
                    }
                }
            }
            .task {
                    await loadUsers()
            }
            .navigationTitle("FriendFace")
        }
    }
    
    func loadUsers() async {
        guard users.isEmpty else { return }
        
        do {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let users = try decoder.decode([User].self, from: data)
            
//            if let decodedResponse = try? decoder.decode([User].self, from: data) {
//                self.users = decodedResponse
//        }
                
            await MainActor.run {
                saveUsers(users: users)
            }
            
        } catch {
            print("Invalid data")
        }
    }
    
    func saveUsers(users: [User]) {
        for user in users {
            let newUser = CachedUser(context: moc)
            
            newUser.id = user.id
            newUser.isActive = user.isActive
            newUser.name = user.name
            newUser.age = Int16(user.age)
            newUser.company = user.company
            newUser.email = user.email
            newUser.address = user.address
            newUser.about = user.about
            newUser.registered = user.registered
            newUser.tags = user.tags.joined(separator: ",")

            for friend in user.friends {
                let newFriend = CachedFriend(context: moc)
                newFriend.id = friend.id
                newFriend.name = friend.name
                
                newUser.addToFriends(newFriend)
            }
        }
        
//        if moc.hasChanges {
//            try? moc.save()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
