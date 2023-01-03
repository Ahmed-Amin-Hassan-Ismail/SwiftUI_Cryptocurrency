//
//  HomeViewModel.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 25/12/2022.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    //MARK: - Variables
    @Published var allCoins: [Coin] = []
    @Published var portfolio: [Coin] = []
    @Published var searchText: String = ""
    @Published var statistics: [Statistic] = []
    
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    
    private var cancellable = Set<AnyCancellable>()
    
    
    
    //MARK: - Init
    init() {
        addSubscribers()
    }
    
    //MARK: - Methods
    private func addSubscribers() {
        
        // update allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map(filterCoins)
            .sink { [weak self] coins in
                guard let self = self else { return }
                self.allCoins = coins
            }
            .store(in: &cancellable)
        
        
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] statistics in
                guard let self = self else { return }
                self.statistics = statistics
            }
            .store(in: &cancellable)
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return coins
        }
        
        return coins.filter({
            $0.name.lowercased().contains(text.lowercased()) ||
            $0.symbol.lowercased().contains(text.lowercased()) ||
            $0.id.lowercased().contains(text.lowercased())
        })
    }
    
    private func mapGlobalMarketData(marketData: MarketData?) -> [Statistic] {
        var statistics = [Statistic]()
        
        guard let data = marketData else {
            return statistics
        }
        
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = Statistic(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        
        statistics.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        return statistics
    }
}
