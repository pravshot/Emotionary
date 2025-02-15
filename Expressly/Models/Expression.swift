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
    
    func getUIImageWithBackground(_ color: UIColor) -> UIImage {
        return self.getUIImage().withBackground(color: color) ?? UIImage()
    }
}

extension UIImage {

  func withBackground(color: UIColor) -> UIImage? {
    var image: UIImage?
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    let imageRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    if let context = UIGraphicsGetCurrentContext() {
      context.setFillColor(color.cgColor)
      context.fill(imageRect)
      draw(in: imageRect, blendMode: .normal, alpha: 1.0)
      image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return image
    }
    return nil
  }

}
