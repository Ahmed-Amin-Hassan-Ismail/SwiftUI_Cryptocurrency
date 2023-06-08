//
//  MarketDataService.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 09/06/2023.
//

import Foundation
import Combine


final class MarketDataService {
    
    //MARK: - Properties
    
    @Published var marketData: MarketData?
    
    private var marketSubscription: AnyCancellable?
    
    
    //MARK: - Init
    
    init() {
        
        fetchMarketData()
    }
    
    //MARK: - Methods
    
    private func fetchMarketData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketSubscription = NetworkManager.fetchData(with: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] globalData in
                guard let self = self else { return }
                self.marketData = globalData.data
                self.marketSubscription?.cancel()
            })
    }
}
