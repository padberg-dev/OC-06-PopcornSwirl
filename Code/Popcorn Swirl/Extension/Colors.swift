//
//  Colors.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 23.11.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import UIKit
import SwiftUI

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension Color {
    
    init(hex: Int) {
        self.init(UIColor(rgb: hex))
    }
    
    static func hex(_ hexColor: String) -> Color {
        let scanner = Scanner(string: hexColor)
        var value: UInt64 = 0
        
        if scanner.scanHexInt64(&value) {
            return Color(hex: Int(value))
        }
        return Color.black
    }
    
    static let first = Color("First")
    static let second = Color("Second")
    static let third = Color("Third")
    static let fourth = Color("Fourth")
    static let fifth = Color("Fifth")
    static let sixth = Color("Sixth")
}
