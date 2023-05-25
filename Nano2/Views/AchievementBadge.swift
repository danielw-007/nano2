//
//  AchievementBadge.swift
//  Nano2
//
//  Created by Daniel Widjaja on 23/05/23.
//

import SwiftUI

struct AchievementBadge: View {
    
    var imageName: String
    var name: String
    var isEarned: Bool
    
    var body: some View {
        VStack (alignment: .center){
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 50)
                .cornerRadius(10)
                .opacity(isEarned ? 1.0 : 0.2)
            
            Text("\(name)")
                .font(.caption)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .frame(width: 80)
    }
}

struct AchievementBadge_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AchievementBadge(imageName: "info_step", name: "First Step", isEarned: true)
            AchievementBadge(imageName: "info_step", name: "First Step", isEarned: false)
        }
    }
}
