//
//  DetailView.swift
//  FriendFace
//
//  Created by Scott Gurney on 19/07/2022.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section("Company") {
                    Text(user.company)
                }
                
                Section("Email") {
                    Text(user.email)
                }
                
                Section("About") {
                    Text(user.about)
                }
                
                Section("Friends") {
                    ForEach(user.friends, id:\.self) { friend in
                            Text(friend.name)
                    }
                }
            }
            Spacer()
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(user: User())
//    }
//}
