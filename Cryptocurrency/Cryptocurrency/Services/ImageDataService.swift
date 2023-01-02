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
    private var imageName: String
    private var folderName = "coin_images"
    private var imageSubscription: AnyCancellable?
    
    
    
    //MARK: - Init
    
    init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        self.getCoinImage()
    }
    
    
    private func getCoinImage() {
        if let savedImage = LocalFileManager.instance.getImage(folderName: folderName,
                                                               ImageName: imageName) {
            self.image = savedImage
            
        } else {
            downloadCoinImage()
            
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkManager.download(url: url)
            .tryMap({ data in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion(completion:),
                  receiveValue: { [weak self] image in
                guard
                    let self = self,
                    let image = image else { return }
                self.image = image
                LocalFileManager.instance.saveImage(image: image,
                                                    folderName: self.folderName,
                                                    imageName: self.imageName)
                self.imageSubscription?.cancel()
            })
    }
}
