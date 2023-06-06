//
//  CoinRowView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 06/06/2023.
//

import SwiftUI

struct CoinRowView: View {
    
    //MARK: - Properties
    
    let coin: Coin
    let showHoldingColumn: Bool
    
    
    //MARK: - Init
    
    init(coin: Coin, showHoldingColumn: Bool) {
        self.coin = coin
        self.showHoldingColumn = showHoldingColumn
    }
    
    //MARK: - Body
    
    var body: some View {
        
        HStack(spacing: 0) {

            leftColumn
            
            Spacer(minLength: 0)
            
            if showHoldingColumn {
                
                centerColumn
            }
            
           rightColumn
        }
    }
}


//MARK: - Setup View

extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            
            Text(String(describing: coin.rank))
                .font(.caption)
                .foregroundColor(Color.theme.accent)
                .frame(minWidth: 30)
            
            Circle()
                .frame(width: 30, height: 30)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .padding(.leading, 6)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            
                Text(coin.currentHoldingsValue.asCurrencyWithTwoDecimal())
                .fontWeight(.bold)
                
                Text((coin.currentHoldings ?? 0.0).asNumberString())
        }
        .font(.subheadline)
        .foregroundColor(Color.theme.accent)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            
            Text(coin.currentPrice.asCurrencyWithSixDecimal())
                .fontWeight(.bold)
                .foregroundColor(Color.theme.accent)
            
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0.0) >= 0 ?
                    Color.theme.green : Color.theme.red
                )
        }
        .font(.subheadline)
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .preferredColorScheme(.light)
            
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .preferredColorScheme(.dark)
        }
    }
}
