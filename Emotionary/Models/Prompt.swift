//
//  Prompt.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import Foundation

struct Prompt {
    
    static let freestyleMessage = "Express yourself freely."
    
    static func random(exclude: String = "") -> String {
        var prompt = exclude
        while prompt == exclude {
            prompt = self.prompts[Int.random(in: 0..<prompts.count)]
        }
        return prompt
    }
    
    private static let prompts: [String] = [
        "Express your day in colors.",
        "Draw a scene from one of your favorite memories.",
        "Draw a place where you feel the most at home.",
        "Sketch an object that holds sentimental value to you.",
        "Draw your favorite season and why it resonates with you.",
        "Illustrate a moment when you felt proud of yourself.",
        "Convey a recent accomplishment.",
        "Imagine your ideal day and sketch a scene from it.",
        "Draw a landscape that reflects your current mood.",
        "Sketch a symbol that represents your core values.",
        "Capture a dream or goal you're working towards.",
        "Draw something that you associate with childhood joy.",
        "Sketch a place you'd like to visit one day.",
        "Draw your favorite thing about yourself.",
        "Illustrate a time when you overcame a challenge.",
        "Create a drawing of something you're grateful for today.",
        "Sketch a person who inspires you.",
        "Draw something that calms your mind.",
        "Paint something that brings you balance and harmony.",
        "Draw something that reminds you of a peaceful morning.",
        "Illustrate a scene from a happy memory in nature.",
        "Sketch a moment when you felt completely at peace.",
        "Create a drawing that represents hope and optimism.",
        "Illustrate a moment when you felt completely connected to someone.",
        "Depict an item that is a core part of your identity.",
        "Create a drawing of a quiet moment you treasure.",
        "Sketch something that reminds you of family.",
        "Draw an object that brings you comfort when you’re feeling down.",
        "Illustrate a scene from a story that inspires you.",
        "Sketch a place you go when you need to recharge.",
        "Sketch an item that represents self-care to you.",
        "Draw a place that represents adventure to you.",
        "Portray something that brings you joy in everyday life.",
        "Depict a moment when you felt connected to the world around you.",
        "Envision something that helps you stay grounded.",
        "Sketch a place you'd go to clear your mind.",
        "Illustrate a moment when you felt free to be yourself.",
        "Visualize a place that represents tranquility to you.",
        "Sketch an object that reminds you of a cherished memory.",
        "Draw an image that represents adventure and exploration.",
        "Capture something that gives you energy.",
        "Reflect on a recent moment of happiness.",
        "Visualize a place that represents safety and security to you.",
        "Illustrate a moment when you felt completely understood.",
        "Sketch an object that reminds you of a loved one.",
        "Reflect on a lesson you've learned recently.",
        "Draw an image that represents your favorite way to relax.",
        "Sketch a place where you can let go of all your worries.",
        "Envision a place that makes you feel inspired.",
        "Capture something that reminds you of the simple pleasures in life.",
        "Visualize a recent moment of personal growth.",
        "Depict an emotion you didn’t expect to feel this week.",
        "Express how you recharge after a long day.",
        "Capture a small moment of joy from today.",
        "Portray a challenge you recently overcame.",
        "Illustrate something you're excited about in the near future.",
        "Reflect on a conversation that stuck with you this week.",
        "Represent a time you felt connected to others.",
        "Convey a recent moment of stillness or calm.",
        "Envision a time when you stepped outside your comfort zone.",
        "Illustrate how you’ve been kind to yourself lately.",
        "Express a beautiful moment you noticed today.",
        "Interpret your feelings about the future.",
        "Depict a recent change in your life.",
        "Reflect on a recent unexpected surprise.",
        "Express your favorite part of today so far.",
        "Depict the last time you felt truly relaxed.",
        "Illustrate something that inspired you this week.",
        "Capture the feeling of completing a task you've been avoiding.",
        "Portray a recent moment of clarity.",
        "Express something that made you laugh today.",
        "Translate your current mood into an abstract design.",
        "Illustrate the feeling of letting go of stress.",
        "Represent a comforting routine in your daily life.",
        "Visualize how your energy feels right now.",
        "Depict how you feel using only geometric shapes.",
        "Capture the texture of an emotion you've been sitting with recently.",
        "Express your current mental space as an abstract landscape.",
        "Capture the energy of a recent conversation in colors.",
        "Visualize your day as a piece of music.",
        "Express the balance between chaos and calm in your life right now.",
        "Draw the first memory that comes to mind when you think of home.",
        "Express what adventure looks like in your imagination.",
        "Sketch something that makes you feel safe.",
        "Draw a graph of your emotions this week.",
        "Illustrate the feeling of letting go.",
        "Express the movement of your thoughts today.",
        "Depict a color that best represents your emotions this morning.",
        "Create a visual map of where your mind has wandered lately.",
        "Capture a feeling of hope you’ve experienced recently.",
        "Draw a scene that represents your favorite holiday.",
        "Draw a symbol of friendship that resonates with you.",
        "Sketch a time when you felt completely content.",
        "Illustrate a scene from your favorite book or movie.",
        "Draw a place that inspires your creativity.",
        "Draw what your childhood imagination looked like.",
        "Sketch a place where you love to sit and think.",
        "Illustrate something that always cheers you up.",
        "Draw one of your hobbies or passions.",
        "Sketch something that represents change in your life.",
        "Illustrate a fictional world you would like to visit.",
        "Draw a cozy corner of your home.",
        "Sketch a moment of kindness you experienced or witnessed.",
        "Illustrate your perfect weekend getaway.",
        "Sketch a tradition that you have.",
        "Draw a scene from a favorite childhood story or fairytale.",
        "Illustrate an abstract representation of your favorite song.",
        "Sketch a moment of generosity that you gave to someone else.",
        "Draw something that makes you feel nostalgic.",
        "Draw a meal that brings you comfort.",
        "Draw a moment of quiet reflection and meditation.",
        "Illustrate a memorable trip or vacation.",
        "Draw a place that feels like an escape to you.",
        "Illustrate a dream you had that felt significant.",
        "Draw a time you felt truly free.",
        "Draw something that symbolizes perseverance to you.",
        "Illustrate a moment when you felt deeply connected to someone.",
        "Capture a moment of discovery.",
        "Illustrate an item on your bucket list.",
        "Draw a place that you associate with learning and growth.",
        "Capture the feeling of a lazy Sunday afternoon.",
        "Draw a vivid daydream you had.",
        "Illustrate a place that feels magical to you.",
        "Draw the cover of a book about your life.",
        "Sketch something that represents independence to you.",
        "Draw a time when you felt incredibly motivated.",
        "Draw a moment when you were mesmerized by nature.",
        "Illustrate a place that you consider a hidden gem.",
        "Draw a sentimental piece of furniture or decor.",
        "Sketch an exciting journey you would like to take.",
        "Draw a snapshot of a typical day in your life.",
        "Illustrate a concept that challenges you or makes you think deeply.",
        "Draw a place where you dream of living one day.",
        "Draw a vision of your future self.",
        "Draw a scene from a memorable event or celebration.",
        "Capture a moment of heartfelt conversation.",
        "Illustrate a scene from your favorite sport.",
        "Sketch a place that feels like a secret hideaway to you.",
        "Sketch your favorite sunrise or sunset.",
        "Illustrate a city you'd love to visit.",
        "Capture the feeling of listening to your favorite music.",
        "Draw a time when you felt completely in the moment.",
        "Draw a favorite childhood toy or game."
    ]
    
    
}
