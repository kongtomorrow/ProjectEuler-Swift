//
//  p40.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/12/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

func countOfNumsWithDigits(numDigits:Int)->Int {
    switch numDigits {
    case 1: return 10
    case _: return pow(10, numDigits) - pow(10, numDigits-1)
    }
}

func digitsConsumedByNumsWithDigits(numDigits:Int)->Int {
    return countOfNumsWithDigits(numDigits)*numDigits
}

func dInverseOfNumDigits(numDigits:Int) -> Int {
    switch numDigits {
    case 1: return 0
    case _: return dInverseOfNumDigits(numDigits-1) + digitsConsumedByNumsWithDigits(numDigits-1)
    }
}

func d(n:Int) -> Int {
    var numDigits = 0
    var indexOfStartOfDigitBlock = 0
    while indexOfStartOfDigitBlock <= n {
        numDigits++
        indexOfStartOfDigitBlock = dInverseOfNumDigits(numDigits)
    }
    (--numDigits)
    
    indexOfStartOfDigitBlock = dInverseOfNumDigits(numDigits)
    
    let indexFromStartOfBlock = (n - indexOfStartOfDigitBlock)
    let num = (indexFromStartOfBlock / numDigits + (numDigits == 1 ? 0 : pow(10, numDigits-1)))
    let digitIndex = (indexFromStartOfBlock % numDigits)
    return digits(num).reverse()[digitIndex]
}


extension Problems {
    func p40() -> Int {
        /*
        An irrational decimal fraction is created by concatenating the positive integers:
        
        0.123456789101112131415161718192021...
        
        It can be seen that the 12th digit of the fractional part is 1.
        
        If dn represents the nth digit of the fractional part, find the value of the following expression.
        
        d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000
        */
        
        // d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000
        return Array(0...6).map({pow(10,$0)}).map(d).reduce(1, combine: *)*** // 210
    }
}
