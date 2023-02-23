//
//  DetailView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 22/02/2023.
//

import SwiftUI

struct DetailView: View {
    
    //MARK: - Properties
    
    @StateObject private var detailCoinViewModel: CoinDetailViewModel
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let columnSpacing: CGFloat = 30.0
    
    //MARK: - Init
    
    init(coin: Coin) {
        print("We have initialized \(coin.name)")
        self._detailCoinViewModel = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }
    
    //MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("")
                    .frame(height: 150)
                                
                overviewTitle
                Divider()
                overviewGrid
                
                
                additionalTitle
                Divider()                
                additionalGrid
                
            }
            .padding()
            
        }
        .navigationTitle(detailCoinViewModel.getCoinDetail().name)
    }
}


//MARK: - overview

extension DetailView {
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: columnSpacing,
            pinnedViews: [],
            content: {
                ForEach(detailCoinViewModel.overviewStatistics) { stat in
                   StatisticView(state: stat)
                }
            })
    }
}

//MARK: - Additional View

extension DetailView {
    
    private var additionalTitle: some View {
        Text("Detail View")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: columnSpacing,
            pinnedViews: [],
            content: {
                ForEach(detailCoinViewModel.additionalStatistics) { stat in
                   StatisticView(state: stat)
                }
            })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}
