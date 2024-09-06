//
//  Emotion.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import Foundation
import SwiftUI

enum Emotion: Int, CaseIterable, Codable, Identifiable {
    var id: Self {
        return self
    }
    
    case sad = 1
    case upset = 2
    case neutral = 3
    case content = 4
    case happy = 5
    
    var icon: String {
        return "emotion\(self.rawValue)"
    }
    var grayed_icon: String {
        return "emotion\(self.rawValue)-gray"
    }
    var color: Color {
        switch self {
            case .sad:
                return Color(red: 0.87, green: 0.19, blue: 0)
            case .upset:
                return Color(red: 1, green: 0.54, blue: 0.25)
            case .neutral:
                return Color(red: 1, green: 0.84, blue: 0.04)
            case .content:
                return Color(red: 0.66, green: 0.87, blue: 0.47)
            case .happy:
                return Color(red: 0.51, green: 0.75, blue: 0.29)
        }
    }
}
