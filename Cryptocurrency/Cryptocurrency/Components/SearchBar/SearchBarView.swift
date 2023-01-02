//
//  SearchBarView.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 02/01/2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .autocorrectionDisabled()
                .overlay(
                    setupClearButton(),
                    alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.25),
                        radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

extension SearchBarView {
    private func setupClearButton() -> some View{
        Image(systemName: "xmark.circle.fill")
            .padding()
            .offset(x: 10)
            .foregroundColor(Color.theme.accent)
            .opacity(searchText.isEmpty ? 0.0 : 1.0)
            .onTapGesture {
                withAnimation(.easeOut) {
                    UIApplication.shared.endEditing()
                    searchText = ""
                }
            }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
