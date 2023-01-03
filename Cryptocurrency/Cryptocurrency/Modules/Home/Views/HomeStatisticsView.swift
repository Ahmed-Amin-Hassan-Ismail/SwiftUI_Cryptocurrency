//
//  HomeStatisticsView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 03/01/2023.
//

import SwiftUI

struct HomeStatisticsView: View {
    
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    @Binding var showPortfolio: Bool
    
    var body: some View {
        
        HStack {
            ForEach(homeViewModel.statistics) { statistic in
                StatisticView(state: statistic)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatisticsView(showPortfolio: .constant(false))
            .environmentObject(HomeViewModel())
    }
}
