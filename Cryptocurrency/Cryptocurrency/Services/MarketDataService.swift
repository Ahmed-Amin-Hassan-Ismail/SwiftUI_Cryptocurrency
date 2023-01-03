//
//  MarketDataService.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 03/01/2023.
//

import Foundation
import Combine

final class MarketDataService {
    
    @Published var  marketData: MarketData?
    
    var marketDataSubscription: AnyCancellable?
    
    
    init() {
        getMarketData()
    }
    
    private func getMarketData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription = NetworkManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion(completion:),
                  receiveValue: { [weak self] globalData in
                guard let self = self else { return }
                self.marketData = globalData.data
                self.marketDataSubscription?.cancel()
            })
        
    }
}
