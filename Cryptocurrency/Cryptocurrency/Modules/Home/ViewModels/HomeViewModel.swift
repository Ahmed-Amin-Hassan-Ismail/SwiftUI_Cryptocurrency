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
    
    private var coinDataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Init
    init() {
     addSubscribers()
    }
    
    //MARK: - Methods
    private func addSubscribers() {
        coinDataService.$allCoins
            .sink { [weak self] coins in
                guard let self = self else { return }
                self.allCoins = coins
            }
            .store(in: &cancellables)
    }
}
