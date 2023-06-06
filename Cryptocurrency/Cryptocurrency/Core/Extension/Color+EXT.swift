//
//  Color+EXT.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 06/06/2023.
//

import SwiftUI



extension Color {
    
    static let theme = ColorTheme()
    static let launchTheme = LaunchTheme()
}


struct ColorTheme {
    let accent          = Color("AccentColor")
    let background      = Color("BackgroundColor")
    let green           = Color("GreenColor")
    let red             = Color("RedColor")
    let secondaryText   = Color("SecondaryTextColor")
}

struct LaunchTheme {
    
    let accent        = Color("LaunchAccentColor")
    let background    = Color("LaunchBackgroundColor")
}
