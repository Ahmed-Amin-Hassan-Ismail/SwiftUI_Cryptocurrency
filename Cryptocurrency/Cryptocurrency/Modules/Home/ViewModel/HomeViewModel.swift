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
    @Published var searchText: String = ""
    @Published var coins: [Coin]?
    @Published var portfolioCoins: [Coin]?
    @Published var statistics: [Statistic]?
    
    private let service = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    
    //MARK: - Init
    
    init() {
        
        addSubscriber()
    }
    
    
    //MARK: - Methods
    
    private func addSubscriber() {
         
        $searchText
            .combineLatest(service.$coins)
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map(filterCoins)
            .sink { coins in
                self.coins = coins
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
