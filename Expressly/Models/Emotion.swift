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
                return Color(red: 0.83, green: 0.18, blue: 0.18)
            case .upset:
                return Color(red: 1, green: 0.6, blue: 0)
            case .neutral:
                return Color(red: 0.94, green: 0.71, blue: 0.03)
            case .content:
                return Color(red: 0, green: 0.66, blue: 0)
            case .happy:
                return Color(red: 0, green: 0.52, blue: 0.36)
        }
    }
}
