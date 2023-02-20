//
//  HapticManager.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 21/02/2023.
//

import Foundation
import SwiftUI


final class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
