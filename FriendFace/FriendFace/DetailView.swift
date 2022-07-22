//
//  DetailView.swift
//  FriendFace
//
//  Created by Scott Gurney on 19/07/2022.
//

import SwiftUI

struct DetailView: View {
    let user: CachedUser
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section("Company") {
                    Text(user.wrappedCompany)
                }
                
                Section("Email") {
                    Text(user.wrappedEmail)
                }
                
                Section("About") {
                    Text(user.wrappedAbout)
                }
                
                Section("Friends") {
                    ForEach(user.friendArray) { friend in
                            Text(friend.wrappedName)
                    }
                }
            }
            .listStyle(.grouped)
            Spacer()
        }
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(user: User())
//    }
//}
