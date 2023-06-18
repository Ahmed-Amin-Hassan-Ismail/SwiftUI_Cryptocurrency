//
//  String+EXT.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 18/06/2023.
//

import Foundation


extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+›", with: "", options: .regularExpression, range: nil)
    }
}
