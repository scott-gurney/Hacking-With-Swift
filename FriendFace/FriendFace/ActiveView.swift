//
//  ActiveView.swift
//  FriendFace
//
//  Created by Scott Gurney on 20/07/2022.
//

import SwiftUI

struct ActiveView: View {
    let isActive: Bool
    
    var image = Image(systemName: "circle.fill")
    
    var activeColor = Color.green
    var inactiveColor = Color.red
    
    var body: some View {
        image
            .foregroundColor(isActive ? activeColor : inactiveColor)
    }
}

struct ActiveView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveView(isActive: true)
    }
}
