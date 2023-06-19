//
//  Date+EXT.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 19/06/2023.
//

import Foundation


extension Date {
    
    init(dateString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-dd'T'HH:mm:ss.SSSZ"
        
        let date = formatter.date(from: dateString) ?? Date()
        
        self.init(timeInterval: 0, since: date)
    }
    
    
    private var shorterFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        return formatter
    }
    
    func asShortDateString() -> String {
        
        return shorterFormatter.string(from: self)
    }
}
