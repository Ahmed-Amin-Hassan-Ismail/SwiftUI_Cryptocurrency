//
//  PersonalInfo.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 21/06/2023.
//

import Foundation



struct PersonalInfo: Identifiable {
    
    var id = UUID().uuidString
    
    var title: String
    var image: String
    var url: URL
}
