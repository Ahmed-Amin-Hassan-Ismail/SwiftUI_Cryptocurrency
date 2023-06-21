//
//  LaunchScreenView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 21/06/2023.
//

import SwiftUI

struct LaunchScreenView: View {
    
    //MARK: - Properties
    
    @Binding var shouldShowLaunchingScreen: Bool
    
    @State private var loadingText: [String] = "Loading your portfolio...".map({ String($0) })
    @State private var showLoadingText: Bool = false
    @State private var counter: Int = 0
    @State private var loop: Int = 0
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    //MARK: - Body
    
    var body: some View {
        ZStack {
            Color.launchTheme.background
                .ignoresSafeArea(.all)
            
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            
            
            ZStack {
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices, id: \.self) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.launchTheme.accent)
                                .offset(y: counter == index ? -5 : 0)
                        }
                    }
                    .transition(.scale.animation(.easeIn))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            withAnimation(.spring()) {
                showLoadingText.toggle()
            }
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                if counter == loadingText.count - 1 {
                    counter = 0
                    loop += 1
                    
                    if loop >= 2 {
                        shouldShowLaunchingScreen = false
                    }
                    
                } else {
                    counter += 1
                }
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView(shouldShowLaunchingScreen: .constant(true))
    }
}
