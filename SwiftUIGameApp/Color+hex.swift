//
//  Color+hex.swift
//  SwiftUIGames
//
//  Created by Berik Visschers on 2019-06-30.
//  Copyright © 2019 Berik Visschers. All rights reserved.
//

import SwiftUI

extension Color {
    init(_ value: Int) {
        let red = Double(value >> 16 & 0xff) / 255.0
        let green = Double(value >> 8 & 0xff) / 255.0
        let blue = Double(value & 0xff) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}


extension Int {

    var color: Color {
        switch self {
        case 1:
            return Color(0x0000FF)
        case 2:
            return Color(0x008000)
        case 3:
            return Color(0xDC143C)
        case 4:
            return Color(0x8A2BE2)
        case 5:
            return Color(0x800000) // Maroon
        case 6:
            return Color(0x40E0D0) // Turquoise
        case 7:
            return .black
        case 8:
            return .gray
        default:
            return .clear
        }
    }
    
}
