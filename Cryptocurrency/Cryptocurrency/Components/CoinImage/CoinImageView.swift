//
//  CoinImageView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 02/01/2023.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject private var coinImageViewModel: CoinImageViewModel
    
    init(coin: Coin) {
        _coinImageViewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = coinImageViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                
            } else if coinImageViewModel.isLoading {
                ProgressView()
                    .font(.largeTitle)
                
            } else {
                
                Image(systemName: "questionmark")
                    .font(.largeTitle)
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
    }
}
