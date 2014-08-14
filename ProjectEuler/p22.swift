//
//  p22.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/10/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p22() -> Int {
        /*
        Names scores
        Problem 22
        Published on 19 July 2002 at 06:00 pm [Server Time]
        Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.
        
        For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.
        
        What is the total of all the name scores in the file?
                
        */
        let namesURL = NSBundle.mainBundle().URLForResource("names", withExtension: "txt")
        let namesData = NSData.dataWithContentsOfURL(namesURL, options: nil, error: nil)
        let names = NSJSONSerialization.JSONObjectWithData(namesData, options: nil, error: nil).sortedArrayUsingSelector("compare:") as [NSString]

        let base = Int("A".characterAtIndex(0)) - 1
        func valueOfName(name:NSString)->Int {
            var sum = 0
            for i in 0..<name.length {
                sum += Int(name.characterAtIndex(i)) - base
            }
            return sum
        }
        
        return (0..<names.count).map({($0+1)*valueOfName(names[$0])}).reduce(0, combine: +)
    }
}