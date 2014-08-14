//
//  p42.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/13/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p42() -> Int {
        /*
        The nth term of the sequence of triangle numbers is given by, tn = ½n(n+1); so the first ten triangle numbers are:
        
        1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
        
        By converting each letter in a word to a number corresponding to its alphabetical position and adding these values we form a word value. For example, the word value for SKY is 19 + 11 + 25 = 55 = t10. If the word value is a triangle number then we shall call the word a triangle word.
        
        Using words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words, how many are triangle words?
        
        */
                
        let aVal = Int(first("A".utf8)!)
        func wordVal(word:String)->Int {
            return reduce(map(word.utf8, {(Int($0) - aVal + 1)}), 0, +)
        }
        
        let wordsURL = NSBundle.mainBundle().URLForResource("words", withExtension: "txt")
        let wordsData = NSData.dataWithContentsOfURL(wordsURL, options: nil, error: nil)
        let words = NSJSONSerialization.JSONObjectWithData(wordsData, options: nil, error: nil) as [String]
        
        return words.map(wordVal).filter(isTriangleNum).count
    }
}

