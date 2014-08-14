//
//  p16.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/9/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    
    func p16() -> Int {
        /*
        Power digit sum
        Problem 16
        Published on 03 May 2002 at 06:00 pm [Server Time]
        2**15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
        
        What is the sum of the digits of the number 2**1000?
        */
        
        var power = 1000
        let resultDigits = reduce(2...power, digits(2)) {
            (prevDigits,_) in
            return digits(prevDigits, timesCoefficient: 2)
        }
        return resultDigits.reduce(0,combine:+) // 1366
    }
}