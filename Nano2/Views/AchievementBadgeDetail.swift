//
//  AchivementBadgeDetail.swift
//  Nano2
//
//  Created by Daniel Widjaja on 25/05/23.
//

import SwiftUI

struct AchievementBadgeDetail: View {
    
    var name: String
    var imageName: String
    var desc: String
    var isEarned: Bool
    
    @Binding var isShown: Bool
    
    var body: some View {
        ZStack {
            
            VStack {
                Rectangle()
                    .fill(.black)
                    .ignoresSafeArea()
                    .opacity(0.7)
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .onTapGesture {
                isShown = false
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .frame(width: 300, height: 300)
                
                VStack (alignment: .center) {
                    Text(name)
                        .font(.title)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .cornerRadius(10)
                        .opacity(isEarned ? 1.0 : 0.2)
                    
                    Text(desc)
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 200)
                }
                .padding()
            }
            
        }
        
    }
}

struct AchievementBadgeDetail_Previews: PreviewProvider {
    static var previews: some View {
        AchievementBadgeDetail(name: "Step-Tactular", imageName: "step-tacular", desc: "A journey of a thousand miles begins with a single step", isEarned: true, isShown: .constant(false))
    }
}
