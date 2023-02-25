//
//  DetailView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 22/02/2023.
//

import SwiftUI

struct DetailView: View {
    
    //MARK: - Properties
    
    @StateObject private var coinDetailViewModel: CoinDetailViewModel
    @State private var showFullDescription: Bool = false
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let columnSpacing: CGFloat = 30.0
    
    //MARK: - Init
    
    init(coin: Coin) {
        self._coinDetailViewModel = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }
    
    //MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: coinDetailViewModel.getCoinDetail())
                    .padding(.vertical)
                
                VStack(spacing: 20) {
                                    
                    overviewTitle
                    Divider()
                    descriptionSection
                    overviewGrid
                    
                    additionalTitle
                    Divider()
                    additionalGrid
                    
                    websiteSection
                    
                }
                .padding()
            }
        }
        .navigationTitle(coinDetailViewModel.getCoinDetail().name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
              navigationBarTrailingItem
            })
        }
    }
}

//MARK: - Navigation Tool Bar

extension DetailView {
    
    private var navigationBarTrailingItem: some View {
        HStack {
            Text(coinDetailViewModel.getCoinDetail().symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: coinDetailViewModel.getCoinDetail())
                .frame(width: 25, height: 25)
        }
        
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
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = coinDetailViewModel.coinDescription,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                        .lineLimit(showFullDescription ? nil : 3)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    }
                    .accentColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: columnSpacing,
            pinnedViews: [],
            content: {
                ForEach(coinDetailViewModel.overviewStatistics) { stat in
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
                ForEach(coinDetailViewModel.additionalStatistics) { stat in
                   StatisticView(state: stat)
                }
            })
    }
}

//MARK: - Links

extension DetailView {
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let website = coinDetailViewModel.websiteURL,
               let url = URL(string: website) {
                
                Link("Website", destination: url)
            }
            
            if let reddit = coinDetailViewModel.redditURL,
               let url = URL(string: reddit) {
                
                Link("Reddit", destination: url)
            }
        }
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .accentColor(.blue)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}
