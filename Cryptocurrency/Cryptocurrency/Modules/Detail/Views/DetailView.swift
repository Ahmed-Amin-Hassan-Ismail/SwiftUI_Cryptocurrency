//
//  DetailView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 22/02/2023.
//

import SwiftUI

struct DetailView: View {
    
    //MARK: - Properties
    
    let coin: Coin
    
    //MARK: - Init
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    //MARK: - Body
    
    var body: some View {
        Text(coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
