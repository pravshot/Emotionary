//
//  Prompt.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import Foundation

class Prompt {
    
    init(freestyle: Bool = false) {
        self.promptIdx = Int.random(in: 0..<prompts.count)
        self.freestyle = freestyle
    }
    
    private var prompts: [String] = [
        "Draw something you're grateful for.",
        "Sketch something that brings you peace.",
        "Express your day in colors."
    ]
    
    private var promptIdx: Int
    
    var freestyle: Bool // if True, no guided prompt
    let freestyleMessage = "Express yourself freely."
    
    var message: String {
        if freestyle {
            return freestyleMessage
        }
        return prompts[promptIdx]
    }
    
    private let previewLength = 35
    var preview: String {
        return message.prefix(previewLength) + "..."
    }
    
    func shuffle() {
        var lastIdx = promptIdx
        while promptIdx == lastIdx {
            promptIdx = Int.random(in: 0..<prompts.count)
        }
    }
}
