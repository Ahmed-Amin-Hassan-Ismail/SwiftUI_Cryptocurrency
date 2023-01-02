//
//  CoinImageViewModel.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 02/01/2023.
//

import SwiftUI
import Combine


final class CoinImageViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    
    private var imageService: ImageDataService
    private var cancellable = Set<AnyCancellable>()
    
    
    //MARK: - Init
    init(coin: Coin) {
        self.imageService = ImageDataService(coin: coin)
        self.addSubscriber()
    }
    
    private func addSubscriber() {
        self.isLoading = true
        
        imageService.$image
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.isLoading = false
                
            } receiveValue: { [weak self] image in
                guard let self = self else { return }
                self.image = image
            }
            .store(in: &cancellable)
        

    }
}
