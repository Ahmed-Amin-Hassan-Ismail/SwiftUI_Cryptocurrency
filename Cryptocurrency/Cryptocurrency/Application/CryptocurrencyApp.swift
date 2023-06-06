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
