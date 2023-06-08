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
    
    private let fileManager = LocalFileManager.instance
    private let fileName = "coin_images"
    private let imageName: String
    private let coin: Coin
    private var imageSubscription: AnyCancellable?
    
    
    //MARK: - Init
    
    init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        
        self.retrieveCoinImage()
    }
    
    //MARK: - Methods
    
    private func retrieveCoinImage() {
        
        if let data = fileManager.getImageDataFromLocal(imageName: imageName, fileName: fileName) {
            
            self.imageData = data
            print("Fetch Images")
            
        } else {
            
            fetchCoinImage(with: coin.image)
            print("Download Images")
        }
    }
    
    private func fetchCoinImage(with stringUrl: String) {
        
        guard let url = URL(string: stringUrl) else { return }
        
        imageSubscription = NetworkManager.fetchData(with: url)
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] data in
                guard let self = self else { return }
                
                self.imageData = data
                self.fileManager.saveImage(imageData: data,
                                           imageName: self.imageName,
                                           fileName: self.fileName)
                self.imageSubscription?.cancel()
                
            })
        
    }
    
}
