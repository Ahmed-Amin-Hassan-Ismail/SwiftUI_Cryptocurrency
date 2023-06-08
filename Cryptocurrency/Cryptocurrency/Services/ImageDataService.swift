//
//  ImageDataService.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 08/06/2023.
//

import Foundation
import Combine


final class ImageDataService {
    
    //MARK: - Properties
    
    @Published var imageData: Data?
    
    private let coin: Coin
    private var imageSubscription: AnyCancellable?
    
    
    //MARK: - Init
    
    init(coin: Coin) {
        self.coin = coin
        fetchCoinImage()
    }
    
    //MARK: - Methods
    
    func fetchCoinImage() {
        
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkManager.fetchData(with: url)
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] data in
                guard let self = self else { return }
                self.imageData = data
                self.imageSubscription?.cancel()
            })
        
    }
    
}
