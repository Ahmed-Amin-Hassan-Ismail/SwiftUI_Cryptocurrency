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
    
    //MARK: - Init
    
    init(coin: Coin?) {
        
        self._viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
