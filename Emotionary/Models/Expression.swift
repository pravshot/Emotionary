//
//  Expression.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import Foundation
import SwiftData
import UIKit

@Model
final class Expression {
    var title: String
    var caption: String
    var emotion: Emotion?
    @Attribute(.externalStorage) var drawing : Data
    var prompt: String
    var date: Date
    var favorite: Bool
    
    init(drawing: Data = Data(), 
         emotion: Emotion? = nil,
         prompt: String = Prompt.random(),
         title: String = "",
         caption: String = "",
         date: Date = Date(),
         favorite: Bool = false)
    {
        self.drawing = drawing
        self.emotion = emotion
        self.prompt = prompt
        self.title = title
        self.caption = caption
        self.date = date
        self.favorite = favorite
    }
    
    func getUIImage() -> UIImage {
        return UIImage(data: self.drawing) ?? UIImage()
    }
}
