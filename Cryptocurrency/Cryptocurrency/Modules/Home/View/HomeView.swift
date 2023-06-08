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
            
            VStack {
                
                headerView
                
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
                    CircleButtonAnimationView(animate: $viewModel.showPortfolio))
            
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
            Text("Coin")
            
            Spacer()
            
            Text("Holding")
                .opacity(viewModel.showPortfolio ? 1.0 : 0.0)
            
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
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
            }
        }
        .listStyle(.plain)
    }
    
    private var protfolioCoinsList: some View {
        
        List {
            ForEach(viewModel.portfolioCoins ?? []) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(rowEdgeInsets)
            }
        }
        .listStyle(.plain)
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
