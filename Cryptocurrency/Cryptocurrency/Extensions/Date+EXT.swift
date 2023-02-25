//
//  DateDate+EXT.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 25/02/2023.
//

import Foundation



extension Date {
    
    init(customString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T 'HH:mm: ss. SSSZ"
        let date = formatter.date(from: customString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        return formatter
    }
    
    func asShortDateFormate() -> String {
        return shortFormatter.string(from: self)
    }
}
