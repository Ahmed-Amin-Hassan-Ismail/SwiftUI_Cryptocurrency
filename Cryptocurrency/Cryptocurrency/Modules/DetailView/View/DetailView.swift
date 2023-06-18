//
//  DetailView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 18/06/2023.
//

import SwiftUI

struct DetailView: View {
    
    //MARK: - Properties
    
    @Binding var coin: Coin?
    
    //MARK: - Init
    
    init(coin: Binding<Coin?>) {
        self._coin = coin
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: .constant(dev.coin))
    }
}
