//
//  Expression.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import Foundation
import SwiftData

@Model
final class Expression {
    var title: String
    var caption: String?
    var emotion: Emotion
    // var drawing : ???
    var prompt: Prompt
    
    init(title: String, caption: String? = nil, emotion: Emotion, prompt: Prompt) {
        self.title = title
        self.caption = caption
        self.emotion = emotion
        self.prompt = prompt
    }
}
