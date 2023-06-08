//
//  CoinDataService.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 06/06/2023.
//

import Foundation
import Combine


final class CoinDataService {
    
    //MARK: - Properties
    
    @Published var coins: [Coin]?
    
    private var coinSubscription: AnyCancellable?
    
    //MARK: - Init
    
    init() {
        fetchCoins()
    }
    
    
    //MARK: - Download Coins
    
    private func fetchCoins() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return}
        
        
        coinSubscription = NetworkManager.fetchData(with: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] coins in
                guard let self = self else { return }
                self.coins = coins
                self.coinSubscription?.cancel()
            })
    }
}
