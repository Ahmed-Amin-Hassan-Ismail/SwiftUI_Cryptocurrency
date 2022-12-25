//
//  HomeViewModel.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 25/12/2022.
//

import Foundation


final class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [Coin] = []
    @Published var portfolio: [Coin] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfolio.append(DeveloperPreview.instance.coin)
            self.portfolio.append(DeveloperPreview.instance.coin)
            
        })
    }
}
