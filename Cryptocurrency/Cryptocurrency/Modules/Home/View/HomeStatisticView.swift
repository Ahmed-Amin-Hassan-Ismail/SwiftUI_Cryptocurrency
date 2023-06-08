//
//  HomeStatisticView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 09/06/2023.
//

import SwiftUI

struct HomeStatisticView: View {
    
    //MARK: - Properties
    
    @EnvironmentObject private var viewModel: HomeViewModel
    @Binding var showPortfolio: Bool
    
    //MARK: - Body
    
    var body: some View {
        
        HStack {
            
            ForEach(viewModel.statistics ?? []) { statistic in
                StatisticView(statistic: statistic)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
            
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ?  .trailing : .leading)
    }
}

struct HomeStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatisticView(showPortfolio: .constant(false))
            .environmentObject(dev.homeViewModel)
    }
}
