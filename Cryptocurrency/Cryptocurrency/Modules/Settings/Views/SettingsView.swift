//
//  SettingsView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 28/02/2023.
//

import SwiftUI

struct SettingsView: View {
    
    //MARK: - Variables
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
    let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://www.nicksarno.com")!
    
    //MARK: - Properties
    
    @StateObject private var settingsViewModel = SettingsViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    
    //MARK: - Body
    
    var body: some View {
        NavigationView {
            List {
                CryptoCurrencySection
                coingeokoSection
                developerSection
                applicationSection
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    }
                }
            }
        }
    }
}

//MARK: -

extension SettingsView {
    private var CryptoCurrencySection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text ("This app was made by following a @SwiftfulThinking course on YouTube. It uses MVVM Architecture, Combine, and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor (Color.theme.accent)
            }
            .padding()
            
            Link("Subscribe on YouTube 🥳",
                 destination: settingsViewModel.urls[1])
            Link("Support his coffee addiction ☕️",
                 destination: settingsViewModel.urls[2])
            
            
        } header: {
            Text("Swiftful Thinking")
        }
    }
    
    
    private var coingeokoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text ("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delaved.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor (Color.theme.accent)
            }
            .padding()
            
            Link("Visit CoinGecko ",
                 destination: settingsViewModel.urls[3])
            
        } header: {
            Text("CoinGecko")
        }
    }
    
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was developed by Nick Sarno. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor (Color.theme.accent)
            }
            .padding()
            
            Link("Personal ", destination: settingsViewModel.urls[4])
            
        } header: {
            Text("Developer")
        }
    }
    
    private var applicationSection: some View {
        Section (header: Text ("Application" )) {
            Link("Terms of Service", destination: settingsViewModel.urls[0])
            Link("Privacy Policy", destination: settingsViewModel.urls[0])
            Link("Company Website", destination: settingsViewModel.urls[0])
            Link("Learn More", destination: settingsViewModel.urls[0])
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
