//
//  CoinDetailDataService.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 23/02/2023.
//

import Foundation
import Combine


final class CoinDetailDataService {
    
    //MARK: - Properties
    
    @Published var coinDetail: CoinDetail? = nil
    
    private let coin: Coin
    private var coinDetailSubscription: AnyCancellable?
    
    //MARK: - Init
    
    init(coin: Coin) {
        self.coin = coin
        self.getCoinDetail()
    }
    
    
    //MARK: - Methods
    
    func getCoinDetail() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        ) else { return }
        
        coinDetailSubscription = NetworkManager.download(url: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] coinDetail in
                guard let self = self else { return }
                self.coinDetail = coinDetail
                self.coinDetailSubscription?.cancel()
            })
        
    }
    
}
