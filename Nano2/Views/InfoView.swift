//
//  InfoView.swift
//  Nano2
//
//  Created by Daniel Widjaja on 23/05/23.
//

import SwiftUI

struct InfoView: View {
    
    var imageName: String
    var description: String
    
    var body: some View {
        VStack {
            Image("\(imageName)")
                .resizable()
                .scaledToFit()
                .frame(width: 60)
                .cornerRadius(10)
            
            Text("\(description)")
                .font(.caption)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .frame(width: 120)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(imageName: "info_step", description: "The data is fetch from Apple Health")
    }
}
