//
//  ImageDataService.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 02/01/2023.
//

import SwiftUI
import Combine


final class ImageDataService {
 
    //MARK: - Properties
    
    @Published var image: UIImage?
    
    private var coin: Coin
    private var imageSubscription: AnyCancellable?
    
    
    
    //MARK: - Init
    
    init(coin: Coin) {
        self.coin = coin
        self.getCoinImage()
    }
    
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkManager.download(url: url)
            .tryMap({ data in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion(completion:),
                  receiveValue: { [weak self] image in
                guard let self = self else { return }
                self.image = image
                self.imageSubscription?.cancel()
            })
    }
}
