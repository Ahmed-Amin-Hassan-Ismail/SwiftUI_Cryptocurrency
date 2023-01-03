//
//  StatisticView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 03/01/2023.
//

import SwiftUI

struct StatisticView: View {
    
    let state: Statistic
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(state.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            
            Text(state.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
            
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (state.percentageChange ?? 0) >= 0 ? 0 : 180 )
                    )
                
                Text(state.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((state.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red )
            .opacity(((state.percentageChange == nil) ? 0.0 : 1.0))
            
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(state: dev.statistic)
    }
}
