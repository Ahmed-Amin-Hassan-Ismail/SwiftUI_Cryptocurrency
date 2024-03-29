//
//  PortfolioViewModel.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 18/06/2023.
//

import Foundation
import Combine


final class PortfolioViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var selectedCoin: Coin?
    @Published var currentValue: String?
    
    @Published var quantityText: String = ""
    @Published var showCheckmark: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    
    //MARK: - Init
    
    init() {
        addSubscribers()
    }
    
    
    //MARK: - Methods
    
    func shouldShowCheckmark() -> Double {
        
        return showCheckmark ? 1.0 : 0.0
    }
    
    func shouldShowSaveButton() -> Double {
        
        return (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
    }
    
    
    //MARK: - Private Methods
    
    private func addSubscribers() {
        
        //update current value
        
        $quantityText
            .combineLatest($selectedCoin)
            .map(mapQuantityCoinsWithCurrentPrice)
            .sink { [weak self] value in
                guard let self = self else { return }
                self.currentValue = value
            }
            .store(in: &cancellables)
    }
    
    
    private func mapQuantityCoinsWithCurrentPrice(quantity: String, coin: Coin?) -> String? {
        
        guard let quantity = Double(quantity) else { return nil }
        
        return "\((quantity * (coin?.currentPrice ?? 0)).asCurrencyWithTwoDecimal())"
    }
    
}
