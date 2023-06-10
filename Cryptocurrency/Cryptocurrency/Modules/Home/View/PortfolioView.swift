//
//  PortfolioView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 10/06/2023.
//

import SwiftUI

struct PortfolioView: View {
    
    //MARK: - Properties
    
    @EnvironmentObject private var viewModel: HomeViewModel
    
    
    //MARK: - Body
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                SearchBarView(searchText: $viewModel.searchText)
                
                coinLogoList
                
            }
        }
        .navigationTitle("Edit Portfolio")
    }
}


extension PortfolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            LazyHStack {
                ForEach(viewModel.coins ?? []) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                viewModel.selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    (viewModel.selectedCoin?.symbol == coin.symbol) ? Color.theme.green : Color.clear
                                    , lineWidth: 1.0)
                        )
                }
            }
            .padding(.vertical, 5)
            .padding(.leading)
        }
    }
}


struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(content: {
            PortfolioView()
        })
        .environmentObject(dev.homeViewModel)
    }
}
