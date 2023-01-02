//
//  UIApplication+EXT.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 02/01/2023.
//

import UIKit

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
