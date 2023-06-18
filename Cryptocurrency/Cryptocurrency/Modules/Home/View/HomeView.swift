//
//  HomeView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 06/06/2023.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: - Properties
    
    @EnvironmentObject private var viewModel: HomeViewModel
    
    private let rowEdgeInsets = EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10)
    
    //MARK: - Body
    
    var body: some View {
        ZStack {
            
            backgroundView
                .background(
                    NavigationLink(isActive: $viewModel.showPortfolioView,
                                   destination: { PortfolioView() },
                                   label: { EmptyView() })
                    .navigationBarTitleDisplayMode(.large)
                )
            
            VStack {
                
                headerView
                
                HomeStatisticView(showPortfolio: $viewModel.showPortfolio)
                
                SearchBarView(searchText: $viewModel.searchText)
                
                columnTitles
                
                if viewModel.showPortfolio {
                    
                    protfolioCoinsList
                        .transition(.move(edge: .trailing))
                } else {
                    
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                
                Spacer(minLength: 0)
            }
        }
        .background(
            NavigationLink(isActive: $viewModel.showDetailView,
                           destination: { DetailView(coin: $viewModel.selectedCoin)},
                           label: { EmptyView() })
        )
    }
}

//MARK: - Setup View

extension HomeView {
    
    //background
    private var backgroundView: some View {
        Color.theme.background
            .ignoresSafeArea()
    }
    
    //header view
    private var headerView: some View {
        
        HStack {
            CircleButtonView(iconName: viewModel.showPortfolio ? "plus" : "info")
                .animation(.none)
                .background(
                    CircleButtonAnimationView(animate: $viewModel.showPortfolio)
                )
                .onTapGesture {
                    if viewModel.showPortfolio {
                        viewModel.didTapOnPlusButton()
                    }
                }
            
            Spacer()
            
            Text(viewModel.showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            
            Spacer()
            
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: viewModel.showPortfolio ? 180 : 0.0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        viewModel.showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    //column titles
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coins")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = (viewModel.sortOption == .rank) ? .rankReversed : .rank
                }
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Text("Holdings")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .holdings || viewModel.sortOption == .holdingsReserved) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .holdings ? 0 : 180))
            }
            .opacity(viewModel.showPortfolio ? 1.0 : 0.0)
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = (viewModel.sortOption == .holdings) ? .holdingsReserved : .holdings
                }
            }
            
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .price || viewModel.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5,
                   alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = (viewModel.sortOption == .price) ? .priceReversed : .price
                }
            }
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    viewModel.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: viewModel.isLoading ? 360 : 0),
                            anchor: .center)
            
            
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
    //coins list
    private var allCoinsList: some View {
        
        List {
            ForEach(viewModel.coins ?? []) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(rowEdgeInsets)
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private var protfolioCoinsList: some View {
        
        List {
            ForEach(viewModel.portfolioCoins ?? []) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(rowEdgeInsets)
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private func segue(coin: Coin?) {
        viewModel.selectedCoin = coin
        viewModel.showDetailView.toggle()
    }
}

//MARK: - Preview

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                HomeView()
                    .preferredColorScheme(.light)
                    .navigationBarHidden(true)
            }
            .environmentObject(dev.homeViewModel)
            
            NavigationView {
                HomeView()
                    .preferredColorScheme(.dark)
                    .navigationBarHidden(true)
            }
            .environmentObject(dev.homeViewModel)
        }
    }
}
