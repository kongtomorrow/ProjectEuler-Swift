//
//  p30.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/11/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p30() -> Int {
        /*
        Digit fifth powers
        Problem 30
        Published on 08 November 2002 at 06:00 pm [Server Time]
        Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:
        
        1634 = 14 + 64 + 34 + 44
        8208 = 84 + 24 + 04 + 84
        9474 = 94 + 44 + 74 + 44
        As 1 = 14 is not a sum it is not included.
        
        The sum of these numbers is 1634 + 8208 + 9474 = 19316.
        
        Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.
        
        */
        
        // claim: can have max 6 digits. for a seven digit number, 9999999 will have the highest sum of fifth powers of digits, and even that only has 6 digits.
        return Array(lazy(2..<1_000_000).filter { (n:Int) -> Bool in
            return n == digits(n).map({pow($0,5)}).reduce(0,combine:+)
        })***.reduce(0,combine:+)
    }
}