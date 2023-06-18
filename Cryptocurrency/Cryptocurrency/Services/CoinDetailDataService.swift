//
//  CoinDetailDataService.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 18/06/2023.
//

import Foundation
import Combine


final class CoinDetailDataService {
    
    //MARK: - Properties
    
    @Published var coinDetail: CoinDetail?
    
    private let coin: Coin?
    private var subscription: AnyCancellable?
    
    
    //MARK: - Init
    
    init(coin: Coin?) {
        self.coin = coin
        self.fetchCoinDetails()
    }
    
    
    //MARK: - Methods
    
    func fetchCoinDetails() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin?.id ?? "")?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        
        subscription = NetworkManager.fetchData(with: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] coinDetail in
                guard let self = self else { return }
                self.coinDetail = coinDetail
                self.subscription?.cancel()
            })
        
        
    }
    
}
