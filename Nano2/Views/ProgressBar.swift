//
//  ProgressBar.swift
//  Nano2
//
//  Created by Daniel Widjaja on 22/05/23.
//

import SwiftUI

struct ProgressBar: View {
    var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.white))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.red))
                    .animation(.linear)
            }
            .cornerRadius(8)
        }
    }
}

//struct ProgressBar_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressBar(value: .constant(50.0))
//    }
//}
