//
//  Emotion.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import Foundation

enum Emotion: String, CaseIterable {
    case sad
    case upset
    case neutral
    case content
    case happy
    
    var icon: String {
        switch self {
        case .sad:
            return "😢"
        case .upset:
            return "😞"
        case .neutral:
            return "😐"
        case .content:
            return "🙂"
        case .happy:
            return "😃"
        }
    }
}
