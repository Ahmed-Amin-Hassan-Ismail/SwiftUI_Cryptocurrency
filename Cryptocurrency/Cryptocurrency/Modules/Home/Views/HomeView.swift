//
//  HomeView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 20/12/2022.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: - Variables
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false
    
    //MARK: - Body
    var body: some View {
        ZStack {
            
            homeBackground
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(homeViewModel)
                }
            
            VStack {
                
                homeHeader
                
                HomeStatisticsView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $homeViewModel.searchText)
                
                columnTitle
                
                if !showPortfolio {
                   allCoinsList
                        .transition(.move(edge: .leading))
                } else {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
               
                
                Spacer(minLength: 0)
            }
        }
    }
}


extension HomeView {
    
    //MARK: - Home Background 
    var homeBackground: some View {
        Color.theme.background
            .ignoresSafeArea()
    }
    
    //MARK: - Header View
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
            
            
            Spacer()
            
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            
            Spacer()
            
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    //MARK: - columnTitle
    private var columnTitle: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coins")
                Image(systemName: "chevron.down")
                    .opacity((homeViewModel.sortOption == .rank || homeViewModel.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: homeViewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    homeViewModel.sortOption = (homeViewModel.sortOption == .rank) ? .rankReversed : .rank
                }
            }
            
            Spacer()
            
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((homeViewModel.sortOption == .holdings || homeViewModel.sortOption == .holdingsReserved) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: homeViewModel.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        homeViewModel.sortOption = (homeViewModel.sortOption == .holdings) ? .holdingsReserved : .holdings
                    }
                }
            }
            
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((homeViewModel.sortOption == .price || homeViewModel.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: homeViewModel.sortOption == .price ? 0 : 180))
            }
                .frame(width: UIScreen.main.bounds.width / 3.5,
                       alignment: .trailing)
                .onTapGesture {
                    withAnimation(.default) {
                        homeViewModel.sortOption = (homeViewModel.sortOption == .price) ? .priceReversed : .price
                    }
                }
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    homeViewModel.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: homeViewModel.isLoading ? 360 : 0),
                            anchor: .center)

            
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
    //MARK: - allCoinsList
    private var allCoinsList: some View {
        List {
            ForEach(homeViewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
        //MARK: - portfolioCoinsList
    private var portfolioCoinsList: some View {
        List {
            ForEach(homeViewModel.portfolio) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
                .preferredColorScheme(.dark)
        }
        .environmentObject(HomeViewModel())
    }
}
