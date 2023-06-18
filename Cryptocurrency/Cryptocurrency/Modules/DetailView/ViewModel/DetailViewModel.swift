//
//  DetailViewModel.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 18/06/2023.
//

import Foundation
import Combine


class DetailViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var coinDetail: CoinDetail?
    
    private let coinDetailService: CoinDetailDataService
    
    private var cancellables = Set<AnyCancellable>()
    
    
    //MARK: - Init
    init(coin: Coin?) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscriber()
    }
    
    
    //MARK: - Methods
    
    private func addSubscriber() {
        
        coinDetailService.$coinDetail
            .sink { [weak self] coinDetail in
                guard let self = self else { return }
                self.coinDetail = coinDetail
                print(self.coinDetail)
            }
            .store(in: &cancellables)
    }
    
}
