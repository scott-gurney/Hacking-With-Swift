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
        Text(user.name)
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(user: User())
//    }
//}
