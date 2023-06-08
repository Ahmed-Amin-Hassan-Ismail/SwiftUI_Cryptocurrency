//
//  CoinImageView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 08/06/2023.
//

import SwiftUI

struct CoinImageView: View {
    
    //MARK: - Properties
    
    @StateObject private var viewModel: CoinImageViewModel
    
    //MARK: - Init
    
    init(coin: Coin) {
        
        self._viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let data = viewModel.imageData,
               let image = UIImage(data: data) {
                
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            } else if viewModel.isLoading {
                
                ProgressView()
                
            } else {
                
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.accent)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
    }
}
