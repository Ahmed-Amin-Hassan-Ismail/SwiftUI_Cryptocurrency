//
//  String+EXT.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 25/02/2023.
//

import Foundation


extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+›", with: "", options: .regularExpression, range: nil)
    }
}
