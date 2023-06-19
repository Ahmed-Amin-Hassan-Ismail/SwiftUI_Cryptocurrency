//
//  ChartView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 19/06/2023.
//

import SwiftUI

struct ChartView: View {
    
    //MARK: - Properties
    
    @State private var chartLinePercentage: CGFloat = 0.0
    
    private let data: [Double]
    private let minY: Double
    private let maxY: Double
    private let averageY: Double
    private let yAxis: Double
    private let lineColor: Color
    private let endDate: Date
    private let startDate: Date
    
    //MARK: - Init
    
    init(coin: Coin) {
        
        self.data = coin.sparklineIn7D?.price ?? []
        self.minY = data.min() ?? 0.0
        self.maxY = data.max() ?? 0.0
        self.averageY = (maxY + minY) / 2
        self.yAxis = maxY - minY
        
        let priceChange = (data.last ?? 0.0) - (data.first ?? 0.0)
        self.lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        self.endDate = Date(dateString: coin.lastUpdated ?? "")
        self.startDate = endDate.addingTimeInterval(-7*24*60*60)
    }
    
    //MARK: - Body
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(chartViewBackground)
                .overlay(chartViewOverlay.padding(.horizontal, 4),
                         alignment: .leading)
            
            charViewDate
                .padding(.horizontal, 4 )
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                withAnimation(.linear(duration: 2.0)) {
                    chartLinePercentage = 1.0
                }
            })
        }
    }
}

//MARK: - Setup View

extension ChartView {
    
    private var chartView: some View {
        GeometryReader { geometry in
            
            Path { path in
                
                for index in data.indices {
                    
                    let xPosition = (geometry.size.width / CGFloat(data.count)) * CGFloat(index + 1)
                    
                    let yPosition = (1 - CGFloat( (data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    
                }
                
            }
            .trim(from: 0.0, to: chartLinePercentage)
            .stroke(lineColor, style: .init(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor,
                    radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.5),
                    radius: 10, x: 0.0, y: 20)
            .shadow(color: lineColor.opacity(0.2),
                    radius: 10, x: 0.0, y: 30)
            .shadow(color: lineColor.opacity(0.1),
                    radius: 10, x: 0.0, y: 40)
        }
    }
    
    private var chartViewBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartViewOverlay: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(averageY.formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    
    private var charViewDate: some View {
        HStack {
            Text(startDate.asShortDateString())
            
            Spacer()
            
            Text(endDate.asShortDateString())
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}
