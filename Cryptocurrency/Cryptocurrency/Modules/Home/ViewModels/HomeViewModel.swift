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
    @Published var searchText: String = ""
    @Published var statistics: [Statistic] = []
    private var coinDataService = CoinDataService()
    private var cancellable = Set<AnyCancellable>()
    
    
    
    //MARK: - Init
    init() {
        addSubscribers()
    }
    
    //MARK: - Methods
    private func addSubscribers() {
        
        // update allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map(filterCoins)
            .sink { [weak self] coins in
                guard let self = self else { return }
                self.allCoins = coins
            }
            .store(in: &cancellable)
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter({
            $0.name.lowercased().contains(text.lowercased()) ||
            $0.symbol.lowercased().contains(text.lowercased()) ||
            $0.id.lowercased().contains(text.lowercased())
        })
    }
}
