//
//  HomeViewModel.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 06/06/2023.
//

import Foundation


final class HomeViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var showPortfolio: Bool = false
    @Published var coins: [Coin]?
    @Published var portfolioCoins: [Coin]?
    
    
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            
            self.coins = [DeveloperPreview.instance.coin, DeveloperPreview.instance.coin]
            
            self.portfolioCoins = [DeveloperPreview.instance.coin, DeveloperPreview.instance.coin]
            
        })
    }
    
    
    //MARK: - Methods
    
    
    
}
