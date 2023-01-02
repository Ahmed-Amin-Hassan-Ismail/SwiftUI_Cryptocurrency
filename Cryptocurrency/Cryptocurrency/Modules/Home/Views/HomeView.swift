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
    
    //MARK: - Body
    var body: some View {
        ZStack {
            
            homeBackground
            
            VStack {
                
                homeHeader
                
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
            Text("Coins")
            Spacer()
            
            if showPortfolio {
                Text("Holdings")
            }
            
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5,
                       alignment: .trailing)
            
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
