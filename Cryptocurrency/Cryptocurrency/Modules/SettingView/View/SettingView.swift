//
//  SettingView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 21/06/2023.
//

import SwiftUI

struct SettingView: View {
    
    //MARK: - Properties
    
    @StateObject private var viewModel = SettingViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    //MARK: - Body
    
    var body: some View {
        NavigationView {
            
            List {
                
                logoSection
                
                personalSection
                
            }
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    dismissButton
                }
            }
        }
    }
}


extension SettingView {
    
    private var logoSection: some View {
        Section {
            HStack(alignment: .top) {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("Bitcoin (BTC) is a cryptocurrency, a virtual currency designed to act as money and a form of payment outside the control of any one person, group, or entity.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.secondaryText)
            }
            
            Link("Official website 🖌️", destination: viewModel.bitCoinWebsite)
                .font(.headline)
                .foregroundColor(.blue)
            
            
        } header: {
            Text("Coin Logo")
        }
    }
    
    private var personalSection: some View {
        Section {
            ForEach(viewModel.info) { personalIfo in
                HStack {
                    Image(personalIfo.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Link(personalIfo.title, destination: personalIfo.url)
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
            
        } header: {
            Text("Personal Websites")
        }
    }
    
    private var dismissButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
            
        } label: {
            
            Image(systemName: "xmark")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
