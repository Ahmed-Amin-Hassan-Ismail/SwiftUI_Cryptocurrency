//
//  CryptocurrencyApp.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 06/06/2023.
//

import SwiftUI

@main
struct CryptocurrencyApp: App {
    
    //MARK: - Properties
    
    @StateObject private var viewModel = HomeViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor(Color.theme.accent)
        ]

        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor(Color.theme.accent)
        ]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(viewModel)
        }
    }
}
