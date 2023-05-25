//
//  Color.swift
//  Nano2
//
//  Created by Daniel Widjaja on 22/05/23.
//

import SwiftUI

extension Color {
    
    // Octomad
    public static var monsterLightGreen: String {
        return "CCEF9F"
    }
    public static var monsterDarkGreen: String {
        return "98DE39"
    }
    
    // Gargantuan
    public static var monsterLightPurple: String {
        return "C8B4FA"
    }
    public static var monsterDarkPurple: String {
        return "7C5DD5"
    }
    
    // Hammerhead
    public static var monsterLightBlue: String {
        return "CFDEF3"
    }
    public static var monsterDarkBlue: String {
        return "85A5CE"
    }
    
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

