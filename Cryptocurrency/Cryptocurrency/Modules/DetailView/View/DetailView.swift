//
//  DetailView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 18/06/2023.
//

import SwiftUI

struct DetailView: View {
    
    //MARK: - Properties
    
    @StateObject private var viewModel: DetailViewModel
    
    private let gridItems: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let gridSpacing: CGFloat = 20.0
    
    //MARK: - Init
    
    init(coin: Coin?) {
        
        self._viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                ChartView(coin: viewModel.coin ?? DeveloperPreview.instance.coin)
                    
                
                overviewTitle
                
                Divider()
                
                overviewBody
                
                
                additionalTitle
                
                Divider()
                
                additionalBody
            }
        }
        .navigationTitle(viewModel.coin?.name ?? "")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarITem
            }
        }
    }
}

//MARK: - SetupView

extension DetailView {
    
    private var overviewTitle: some View {
        
        Text("Overview")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
    
    private var overviewBody: some View {
        
        LazyVGrid(
           columns: gridItems,
           alignment: .leading,
           spacing: gridSpacing) {
               ForEach(viewModel.overviewStatistics ?? []) { statistic in
                   StatisticView(statistic: statistic)
               }
           }
           .padding(.horizontal)
    }
    
    
    private var additionalTitle: some View {
        
        Text("Additional Details")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
    
    private var additionalBody: some View {
        
        LazyVGrid(
           columns: gridItems,
           alignment: .leading,
           spacing: gridSpacing) {
               ForEach(viewModel.additionalStatistics ?? []) { statistic in
                   StatisticView(statistic: statistic)
               }
           }
           .padding(.horizontal)
    }
    
    private var navigationBarITem: some View {
        HStack {
            Text(viewModel.coin?.symbol.uppercased() ?? "")
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
            CoinImageView(coin: viewModel.coin ?? DeveloperPreview.instance.coin )
                .frame(width: 25, height: 25)
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}
