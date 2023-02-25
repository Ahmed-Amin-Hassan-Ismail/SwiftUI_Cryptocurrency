//
//  CoinDetailViewModel.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 23/02/2023.
//

import Foundation
import Combine

final class CoinDetailViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var overviewStatistics: [Statistic] = []
    @Published var additionalStatistics: [Statistic] = []
    @Published var coin: Coin
    @Published var coinDescription: String?
    @Published var websiteURL: String?
    @Published var redditURL: String?
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Init
    init(coin: Coin) {
        
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    //MARK: - Methods
    
    private func addSubscribers() {
        
        coinDetailDataService.$coinDetail
            .combineLatest($coin)
            .map(mapCoinDetailWithCoin)
            .sink { [weak self] returnedArray in
                guard let self = self else { return }
                self.overviewStatistics = returnedArray.overview
                self.additionalStatistics = returnedArray.additional
            }
            .store(in: &cancellables)
        
        coinDetailDataService.$coinDetail
            .sink { [weak self] coinDetail in
                guard let self = self else { return }
                self.coinDescription = coinDetail?.readableDescription
                self.websiteURL = coinDetail?.links?.homepage?.first
                self.redditURL = coinDetail?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Getters
    
    func getCoinDetail() -> Coin {
        return coin
    }
    
    //MARK: - Helper Methods
    
    private func mapCoinDetailWithCoin(coinDetailModel: CoinDetail?, coinModel: Coin) -> (overview: [Statistic], additional: [Statistic]) {
        let overview = createOverviewArray(coinDetailModel: coinDetailModel, coinModel: coinModel)
        let additional = createAdditionalArray(coinDetailModel: coinDetailModel, coinModel: coinModel)
        return (overview, additional)
    }
    
    private func createOverviewArray(coinDetailModel: CoinDetail?, coinModel: Coin) -> [Statistic] {
        // overview
        let price = coinModel.currentPrice.asCurrencyWithSixDecimal()
        let priceChange = coinModel.priceChangePercentage24H
        let priceStat = Statistic(title: "Current Price", value: price, percentageChange: priceChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = Statistic(title: "Market Capitalization", value: marketCap, percentageChange: marketCapChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = Statistic(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = Statistic(title: "Volume", value: volume)

        let overviewArrav: [Statistic] = [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
        
        return overviewArrav
    }
    
    private func createAdditionalArray(coinDetailModel: CoinDetail?, coinModel: Coin) -> [Statistic] {
        // additional
        let high = coinModel.high24H?.asCurrencyWithSixDecimal() ?? "n/a"
        let highStat = Statistic(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWithSixDecimal ( ) ?? "n/a"
        let lowStat = Statistic(title: "24h Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWithSixDecimal() ?? "n/a"
        let pricePercentChange2 = coinModel.priceChangePercentage24H
        let priceChangeStat = Statistic(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange2)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations () ?? "")
        let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = Statistic(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange2)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = Statistic(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = Statistic(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray: [Statistic] = [
        highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
        ]
        
        return additionalArray
    }
    
}
