//
//  HomeViewModel.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 25/12/2022.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    //MARK: - Enum
    
    enum SortOption {
        case rank, rankReversed
        case holdings, holdingsReserved
        case price, priceReversed
    }
    
    //MARK: - Variables
    
    @Published var allCoins: [Coin] = []
    @Published var portfolio: [Coin] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var statistics: [Statistic] = []
    @Published var sortOption: SortOption = .holdings
    
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataservice = PortfolioDataservice()
    
    private var cancellable = Set<AnyCancellable>()
    
    
    
    //MARK: - Init
    
    init() {
        addSubscribers()
    }
    
    //MARK: - Public Methods
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success)
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataservice.updatePortfolio(coin: coin, amoun: amount )
    }
    
    
    //MARK: - Private Methods
    
    private func addSubscribers() {
        
        // update allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map(filterAndSortCoins)
            .sink { [weak self] coins in
                guard let self = self else { return }
                self.allCoins = coins
            }
            .store(in: &cancellable)
        
        // update portfolio
        $allCoins
            .combineLatest(portfolioDataservice.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] coin in
                guard let self = self else { return }
                self.portfolio = self.sortPortfolioCoinsIfNeeded(coins: coin)
            }
            .store(in: &cancellable)
        
        // update market
        marketDataService.$marketData
            .combineLatest($portfolio)
            .map(mapGlobalMarketData)
            .sink { [weak self] statistics in
                guard let self = self else { return }                
                self.statistics = statistics
                self.isLoading = false
            }
            .store(in: &cancellable)
        
    }
    
    private func filterAndSortCoins(text: String, coins: [Coin], sortOption: SortOption) -> [Coin]{
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sortOption, coins: &updatedCoins)
        return updatedCoins
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
    
    private func sortCoins(sort: SortOption, coins: inout [Coin]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReserved:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }
    
    private func mapGlobalMarketData(marketData: MarketData?, portfolioCoins: [Coin]) -> [Statistic] {
        var statistics = [Statistic]()
        
        guard let data = marketData else {
            return statistics
        }
        
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = Statistic(title: "Portfolio Value",
                                  value: getProtfolioValueAndPercentageVaue(portfolioCoins: portfolioCoins).protfolioValue.asCurrencyWithTwoDecimal(),
                                  percentageChange: getProtfolioValueAndPercentageVaue(portfolioCoins: portfolioCoins).percentageValue)
        
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
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        return (portfolioValue, percentageChange)
    }
    
    private func mapAllCoinsToPortfolioCoins(coins: [Coin], portfolioEntity: [PortfolioEntity]) -> [Coin] {
        coins
            .compactMap { coin in
                guard let entity = portfolioEntity.first(where: {$0.coinId == coin.id}) else {
                    return nil
                }
                
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [Coin]) -> [Coin] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReserved:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }
}
