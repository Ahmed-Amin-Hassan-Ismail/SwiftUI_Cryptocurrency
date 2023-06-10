//
//  CoinLogoView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 10/06/2023.
//

import SwiftUI

struct CoinLogoView: View {
    
    //MARK: - Properties
    
    private let coin: Coin
    
    //MARK: - Init
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    //MARK: - Body
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
            
            
        }
    }
}

struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        CoinLogoView(coin: dev.coin)
    }
}
