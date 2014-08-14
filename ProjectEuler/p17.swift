//
//  p17.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/9/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

//let space = " "
//let hyphen = "-"
private let space = ""
private let hyphen = ""
private func toWords(n:Int) -> String {
    switch n {
    case 0: return "zero"
    case 1: return "one"
    case 2: return "two"
    case 3: return "three"
    case 4: return "four"
    case 5: return "five"
    case 6: return "six"
    case 7: return "seven"
    case 8: return "eight"
    case 9: return "nine"
    case 10: return "ten"
    case 11: return "eleven"
    case 12: return "twelve"
    case 13: return "thirteen"
    case 14: return "fourteen"
    case 15: return "fifteen"
    case 16: return "sixteen"
    case 17: return "seventeen"
    case 18: return "eighteen"
    case 19: return "nineteen"
    case 20: return "twenty"
    case 30: return "thirty"
    case 40: return "forty"
    case 50: return "fifty"
    case 60: return "sixty"
    case 70: return "seventy"
    case 80: return "eighty"
    case 90: return "ninety"
    case 20...99:
        return toWords((n/10)*10) + hyphen + toWords(n%10)
    case 100...999:
        if n%100 == 0 {
            return toWords(n/100) + space + "hundred"
        } else {
            return toWords(n/100) + space + "hundred" + space + "and" + space + toWords(n%100)
        }
    case 1000: return "one" + space + "thousand"
    default:
        println("something went wrong!!")
        return ""
    }
}

extension Problems {
    
    func p17() -> Int {
        /*
        Number letter counts
        Problem 17
        Published on 17 May 2002 at 06:00 pm [Server Time]
        If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
        
        If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
        
        
        NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.
        
        */
        
        // need to define toWords at top level due to (prerelease) compiler issue with nested functions
        return (1...1000).map(toWords).map(countElements).reduce(0, combine: +) // 21124
    }
}