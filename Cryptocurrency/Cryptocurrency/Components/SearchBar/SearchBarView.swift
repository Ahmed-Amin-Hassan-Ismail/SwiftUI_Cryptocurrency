//
//  SearchBarView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 08/06/2023.
//

import SwiftUI

struct SearchBarView: View {
    
    //MARK: - Properties
    
    @Binding var searchText: String
    
    //MARK: - Body
    
    var body: some View {
        
        HStack(spacing: 5) {
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ?
                                 Color.theme.secondaryText :
                                    Color.theme.accent)
            
            
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .autocorrectionDisabled()
                .overlay(setupClearButton(), alignment: .trailing)
            
            
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.25),
                        radius: 10, x: 0.0, y: 0.0)
        )
        .padding()
        
    }
}

//MARK: - setupClearButton

extension SearchBarView {
    
    private func setupClearButton() -> some View {
        Image(systemName: "xmark.circle.fill")
            .foregroundColor(Color.theme.accent)
            .padding()
            .offset(x: 10)
            .opacity(searchText.isEmpty ? 0.0 : 1.0)
            .onTapGesture {
                withAnimation(.easeOut) {
                    searchText = ""
                    UIApplication.shared.endEditing()
                }
            }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
