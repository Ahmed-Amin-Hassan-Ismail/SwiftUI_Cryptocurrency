//
//  LoadingDetailView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 22/02/2023.
//

import SwiftUI

struct LoadingDetailView: View {
    
    //MARK: - Properties
    
    @Binding var coin: Coin?
    
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct LoadingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingDetailView(coin: .constant(dev.coin))
    }
}
