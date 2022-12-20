//
//  CryptocurrencyApp.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 20/12/2022.
//

import SwiftUI

@main
struct CryptocurrencyApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
