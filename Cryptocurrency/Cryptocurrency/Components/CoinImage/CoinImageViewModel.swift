//
//  CoinImageViewModel.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 08/06/2023.
//

import Foundation
import Combine


final class CoinImageViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var imageData: Data?
    @Published var isLoading: Bool = false
    
    private let coin: Coin
    private let service: ImageDataService
    private var cancellables = Set<AnyCancellable>()
    
    
    //MARK: - Init
     
    init(coin: Coin) {
        
        self.coin = coin
        self.service = ImageDataService(coin: coin)
        
        addSubscriber()
    }
    
    //MARK: - Methods
    
    private func addSubscriber() {
        isLoading = true
        
        service.$imageData
            .sink { [weak self] data in
                guard let self = self else { return }
                
                self.isLoading = false
                self.imageData = data
            }
            .store(in: &cancellables)
    }
}
