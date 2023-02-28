//
//  SettingsViewModel.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 28/02/2023.
//

import Foundation


final class SettingsViewModel: ObservableObject {
        
    //MARK: - Publisher
    
    @Published var urls: [URL] = []
    
    //MARK: - Init

    init() {
     getURLS()
    }
    
    //MARK: - Methods
    
    private func getURLS() {
        let defaultURL = URL(string: "https://www.google.com")!
        let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
        let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
        let coingeckoURL = URL(string: "https://www.coingecko.com")!
        let personalURL = URL(string: "https://www.nicksarno.com")!
        
        urls.append(defaultURL)
        urls.append(youtubeURL)
        urls.append(coffeeURL)
        urls.append(coingeckoURL)
        urls.append(personalURL)
    }
    
}
