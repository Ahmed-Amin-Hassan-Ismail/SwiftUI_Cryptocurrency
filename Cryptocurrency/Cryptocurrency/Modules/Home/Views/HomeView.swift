//
//  HomeView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 20/12/2022.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: - Variables
    @State private var showPortfolio: Bool = false
    
    //MARK: - Body
    var body: some View {
        ZStack {
            // background layer
            homeBackground
            
            VStack {
                // header View
                homeHeader
                
                Spacer(minLength: 0)
            }
        }
    }
}


extension HomeView {
    
    //MARK: - Home Background 
    var homeBackground: some View {
        Color.theme.background
            .ignoresSafeArea()
    }
    
    //MARK: - Header View
    var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            
            
            Spacer()
            
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            
            Spacer()
            
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
    }
}
