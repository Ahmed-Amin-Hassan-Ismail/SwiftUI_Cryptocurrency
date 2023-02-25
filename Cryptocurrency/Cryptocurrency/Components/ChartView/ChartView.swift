//
//  ChartView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 25/02/2023.
//

import SwiftUI

struct ChartView: View {
    
    //MARK: - Properties
    
    @State private var percentage: CGFloat = 0.0
    
    private let data: [Double]
    private let minY: Double
    private let maxY: Double
    
    private let lineColor: Color
    
    private let startingDate: Date
    private let endingDate: Date
    
    
    //MARK: - Init
    
    init(coin: Coin) {
        self.data = coin.sparklineIn7D?.price ?? []
        self.maxY = data.max() ?? 0.0
        self.minY = data.min() ?? 0.0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        self.lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        self.endingDate = Date(customString: coin.lastUpdated ?? "")
        self.startingDate = endingDate.addingTimeInterval(-7*24*60*60 )
    }
    
    
    //MARK: - Body
    
    var body: some View {
        
        VStack {
            chartView
                .frame(height: 200)
                .background(chartDividerBackground)
                .overlay(chartYAxis.padding(.horizontal, 4), alignment: .leading)
            
            chartDateLabels
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            })
        }
        
    }
}


//MARK: - ChartView

extension ChartView {
    
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                
                for index in data.indices {
                    
                    let xPosition = geometry.size.width / CGFloat (data.count) * CGFloat (index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = ( 1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
                
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 40)
        }
    }
    
    
    private var chartDividerBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabels: some View {
        HStack {
            Text(startingDate.asShortDateFormate())
            
            Spacer()
            
            Text(endingDate.asShortDateFormate())
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}
