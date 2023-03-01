//
//  LaunchView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 01/03/2023.
//

import SwiftUI

struct LaunchView: View {
    
    //MARK: - Variables
    
    @State private var loadingText: [String] = "Loading your portfolio...".map({ String($0) })
    @State private var showLoadingText: Bool = false
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchView: Bool
    
    private let timer = Timer
        .publish(every: 0.1, on: .main, in: .common)
        .autoconnect()
    
    
    
    //MARK: - Body
    
    var body: some View {
        ZStack {
            Color.launchTheme.background
                .ignoresSafeArea(.all)
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices, id: \.self) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.launchTheme.accent )
                                .offset(y: counter == index ? -5 : 0)
                                
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                    .offset(y: 70)
                }
            
        }
        .onAppear {
            showLoadingText = true
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring()) {
                
                if counter == loadingText.count - 1 {
                    counter = 0
                    loops += 1
                    
                    if loops >= 2 {
                        showLaunchView = false
                    }
                    
                } else {
                    counter += 1
                }
            }
        })
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
            .preferredColorScheme(.dark)
    }
}
