//
//  p38.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/12/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p38() -> Int {
        /*
        Take the number 192 and multiply it by each of 1, 2, and 3:
        
        192 × 1 = 192
        192 × 2 = 384
        192 × 3 = 576
        By concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576 the concatenated product of 192 and (1,2,3)
        
        The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the pandigital, 918273645, which is the concatenated product of 9 and (1,2,3,4,5).
        
        What is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer with (1,2, ... , n) where n > 1?
        */
        var maxPan = 0
        nextN: for n in 1...9999 {
            var digitsBitmask = 0 as UInt
            for coeff in 1...9 {
                var rest = n*coeff
                while rest > 0 {
                    let newDigit = rest % 10
                    let newDigitBitmask = 1 << UInt(newDigit)
                    if (newDigit == 0) || (digitsBitmask & newDigitBitmask) != 0 {
                        continue nextN
                    }
                    digitsBitmask |= newDigitBitmask
                    rest /= 10
                }
                if digitsBitmask == 0b1111111110 {
                    let panDigital = Array(1...coeff).map({$0*n}).reduce("", combine: {$0 + $1.description}).toInt()!
                    maxPan = max(maxPan,panDigital)
                }
            }
        }
        return maxPan // 932718654
    }
}
