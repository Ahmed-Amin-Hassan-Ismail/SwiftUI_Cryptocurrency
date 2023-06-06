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
    @Published var coins: [Coin]?
    @Published var portfolioCoins: [Coin]?
    
    private let service = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    
    //MARK: - Init
    
    init() {
        
        addSubscriber()
    }
    
    
    //MARK: - Methods
    
    private func addSubscriber() {
        
        service.$coins
            .sink { [weak self] coins in
                guard let self = self else { return }
                self.coins = coins
            }
            .store(in: &cancellables)
    }
}
