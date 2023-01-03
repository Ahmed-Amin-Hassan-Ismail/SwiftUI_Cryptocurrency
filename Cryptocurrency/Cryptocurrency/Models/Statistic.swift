//
//  Statistic.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 03/01/2023.
//

import Foundation


struct Statistic: Identifiable {
    var id = UUID().uuidString
    
    var title: String
    var value: String
    var percentageChange: Double?
    
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
