//
//  PortfolioView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 10/06/2023.
//

import SwiftUI

struct PortfolioView: View {
    
    //MARK: - Properties
    
    @StateObject private var viewModel = PortfolioViewModel()
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    
    //MARK: - Body
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                SearchBarView(searchText: $homeViewModel.searchText)
                
                coinLogoList
                
                if viewModel.selectedCoin != nil {
                    portfolioInputSection
                }
                
            }
        }
        .navigationTitle("Edit Portfolio")
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                saveButton()
            }
        }
        .onChange(of: homeViewModel.searchText, perform: { newValue in
            if newValue.isEmpty {
                removeSelectedCoin()
            }
        })
        .onDisappear {
            removeSelectedCoin()
        }
    }
}


extension PortfolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(homeViewModel.searchText.isEmpty ? homeViewModel.portfolioCoins ?? [] : homeViewModel.coins ?? []) { coin in
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
    
    private func updateSelectedCoin(coin: Coin?) {
        viewModel.selectedCoin = coin
        
        guard let portfolioCoin = homeViewModel.portfolioCoins?.first(where: { $0.id == coin?.id }),
        let amount = portfolioCoin.currentHoldings else {
            
            viewModel.quantityText = ""
            return
        }
        
        viewModel.quantityText = "\(amount)"
        
    }
    
    private var portfolioInputSection: some View {
        
        VStack(spacing: 10) {
            
            HStack {
                Text("Current price of \(viewModel.selectedCoin?.symbol.uppercased() ?? "")")
                
                Spacer()
                
                Text(viewModel.selectedCoin?.currentPrice.asCurrencyWithSixDecimal() ?? "")
            }
            
            Divider()
            
            HStack {
                Text("Amount holding:")
                
                Spacer()
                
                TextField("EX: 1.4" , text: $viewModel.quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            
            Divider()
            
            HStack {
                Text("Current Value")
                
                Spacer()
                
                Text(viewModel.currentValue ?? "$0.00")
            }
        }
        .font(.headline)
        .animation(.none)
        .padding()
    }
    
    private func saveButton() -> some View {
        
        HStack(spacing: 0) {
            
            Image(systemName: "checkmark")
                .opacity(viewModel.shouldShowCheckmark())
            
            Button {
                
                didTapOnSaveButton()
                
            } label: {
                
                Text("save".uppercased())
                    .opacity(viewModel.shouldShowSaveButton())
            }
        }
        .font(.headline)
    }
    
    private func didTapOnSaveButton() {
        
        guard let coin = viewModel.selectedCoin,
              let quantity = Double(viewModel.quantityText) else { return }
        
        //save to database
        homeViewModel.updatePortfolio(coin: coin, amount: quantity)
        
        
        //show checkmark
        withAnimation(.easeIn) {
            viewModel.showCheckmark = true
            removeSelectedCoin()
            
        }
        
        //hide keyboard
        UIApplication.shared.endEditing()
        
        //hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            withAnimation(.easeOut) {
                viewModel.showCheckmark = false
                
            }
        })
    }
    
    private func removeSelectedCoin() {
        viewModel.selectedCoin = nil
        viewModel.quantityText = ""
        homeViewModel.searchText = ""
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
