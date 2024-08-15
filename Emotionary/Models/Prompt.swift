//
//  Prompt.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import Foundation

struct Prompt {
    
    private static let prompts: [String] = [
        "Draw something you're grateful for.",
        "Sketch something that brings you peace.",
        "Express your day in colors.",
        "Draw a scene from one of your favorite memories."
    ]
    
    static let freestyleMessage = "Express yourself freely."
    
    static func random(exclude: String = "") -> String {
        var prompt = exclude
        while prompt == exclude {
            prompt = self.prompts[Int.random(in: 0..<prompts.count)]
        }
        return prompt
    }
    
}
