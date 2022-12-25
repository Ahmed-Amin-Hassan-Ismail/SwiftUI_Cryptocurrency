//
//  CoinRowView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 21/12/2022.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: Coin
    let showHoldingColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            
            leftColumn
            
            Spacer()
            
            if showHoldingColumn {
                centerColumn
            }
            
            rightColumn
            
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
