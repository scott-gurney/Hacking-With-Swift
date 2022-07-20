//
//  ContentView.swift
//  FriendFace
//
//  Created by Scott Gurney on 19/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                NavigationLink(destination: DetailView(user: user)) {
                    HStack {
                        ActiveView(isActive: user.isActive)
                            .padding(.trailing)
                    
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            Text(user.company)
                        }
                    }
                }
            }
            .task {
                if (users.isEmpty) {
                    await loadUsers()
                }
            }
            .navigationTitle("FriendFace")
        }
    }
    
    func loadUsers() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                self.users = decodedResponse
            }
            
        } catch {
            print("Invalid data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
