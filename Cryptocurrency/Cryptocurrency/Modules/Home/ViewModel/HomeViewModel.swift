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
    @Published var coins: [Coin]?
    @Published var portfolioCoins: [Coin]?
    @Published var statistics: [Statistic]?
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    
    //MARK: - Init
    
    init() {
        
        addSubscriber()
    }
    
    
    func didTapOnPlusButton() {
        showPortfolioView.toggle()
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
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
        
        //update portfolio coins
        $coins
            .combineLatest(portfolioDataService.$savedPortfolioData)
            .map { (coins, entities) -> [Coin]? in
                
                coins?.compactMap({ coin -> Coin? in
                    guard let entity = entities?.first(where: { $0.coinId == coin.id }) else {
                        return nil
                    }
                    
                    return coin.updateHoldings(amount: entity.amount)
                })
            }
            .sink { [weak self] portfolioCoins in
                guard let self = self else { return }
                self.portfolioCoins = portfolioCoins
            }
            .store(in: &cancellables)
        
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
                                  value: getProtfolioValueAndPercentageVaue(portfolioCoins: portfolioCoins ?? []).protfolioValue.asCurrencyWithTwoDecimal(),
                                  percentageChange: getProtfolioValueAndPercentageVaue(portfolioCoins: portfolioCoins ?? []).percentageValue)
        
        
        statistics.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        return statistics
    }
    
    private func getProtfolioValueAndPercentageVaue(portfolioCoins: [Coin]) -> (protfolioValue: Double, percentageValue: Double) {
        let portfolioValue =
        portfolioCoins
            .map({ $0.currentHoldingsValue})
            .reduce(0, +)
        
        let previousValue =
        portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentageValue = coin.priceChangePercentage24H ?? 0 / 100
                let previousValue = currentValue / (1 + percentageValue)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue)
        
        return (portfolioValue, percentageChange)
    }
}
