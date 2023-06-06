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
        
        
        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    
                    throw URLError(.badServerResponse)
                }
                
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                default:
                    break
                }
            } receiveValue: { [weak self] coins in
                guard let self = self else { return }
                self.coins = coins
                self.coinSubscription?.cancel()
            }
        
        
        
        
    }
}
