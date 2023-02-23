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
    
    @Published var coinDetail: CoinDetail? = nil
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Init
    init(coin: Coin) {
        
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
    }
    
    //MARK: - Methods
    
    private func addSubscribers() {
        
        coinDetailDataService.$coinDetail
            .sink { [weak self] coinDetail in
                guard let self = self else { return }
                self.coinDetail = coinDetail
            }
            .store(in: &cancellables)
    }
}
