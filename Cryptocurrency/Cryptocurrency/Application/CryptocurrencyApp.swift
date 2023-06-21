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
    @State private var shouldShowLaunchingScreen: Bool = true
    
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
            
            ZStack {
                
                if shouldShowLaunchingScreen {
                    
                    LaunchScreenView(shouldShowLaunchingScreen: $shouldShowLaunchingScreen)
                        .transition(.move(edge: .leading))
                        .zIndex(2.0)
                    
                } else {
                    
                    NavigationView {
                        HomeView()
                            .navigationBarHidden(true)
                    }
                    .navigationViewStyle(.stack)
                    .environmentObject(viewModel)
                }
            }
            
        }
    }
}
