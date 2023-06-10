//
//  HomeViewModel.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 06/06/2023.
//

import Foundation
import Combine


final class HomeViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var showPortfolio: Bool = false
    @Published var showPortfolioView: Bool = false
    @Published var searchText: String = ""
    @Published var selectedCoin: Coin?
    @Published var coins: [Coin]?
    @Published var portfolioCoins: [Coin]?
    @Published var statistics: [Statistic]?
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    
    //MARK: - Init
    
    init() {
        
        addSubscriber()
    }
    
    
    //MARK: - Methods
    
    private func addSubscriber() {
         
        //update coins
        $searchText
            .combineLatest(coinDataService.$coins)
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map(filterCoins)
            .sink { [weak self] coins in
                guard let self = self else { return }
                
                self.coins = coins
            }
            .store(in: &cancellables)
        
        //update market data
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] statistics in
                guard let self = self else { return }
                
                self.statistics = statistics
            }
            .store(in: &cancellables)
        
    }
    
    func didTapOnPlusButton() {
        showPortfolioView.toggle()
    }
    
}

//MARK: - Search and Sort

extension HomeViewModel {
    
    private func filterCoins(text: String, coins: [Coin]?) -> [Coin]? {
        
        guard isSearchBarNoEmpty(with: text) else {
            return coins
        }
        
        return coins?.filter({
            startFilter(with: text, coinValue: $0.name) ||
            startFilter(with: text, coinValue: $0.symbol) ||
            startFilter(with: text, coinValue: $0.id)
        })
    }
    
    private func isSearchBarNoEmpty(with text: String) -> Bool {
        
        return !(text.isEmpty)
    }
    
    private func startFilter(with searchText: String, coinValue: String) -> Bool {
        
        coinValue.lowercased().contains(searchText.lowercased())
    }
}

//MARK: - Market Data

extension HomeViewModel {
    
    private func mapGlobalMarketData(marketData: MarketData?) -> [Statistic] {
        var statistics = [Statistic]()
        
        guard let data = marketData else {
            return statistics
        }
        
        let marketCap = Statistic(title: "Market Cap",
                                  value: data.marketCap,
                                  percentageChange: data.marketCapChangePercentage24HUsd)
        
        let volume = Statistic(title: "24h Volume",
                               value: data.volume)
        
        let btcDominance = Statistic(title: "BTC Dominance",
                                     value: data.btcDominance)
         
        let portfolio = Statistic(title: "Portfolio Value",
                                  value: "$0.00",
                                  percentageChange: 0)
        
        statistics.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        return statistics
    }
}
