//
//  p4.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/7/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p4() -> Int {
        /* 
        Largest palindrome product
        Problem 4
        Published on 16 November 2001 at 06:00 pm [Server Time]
        A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
        
        Find the largest palindrome made from the product of two 3-digit numbers.
        */
        let digitCount = 3
        var best = Int.min
        
        let minFactor = pow(10,digitCount-1)
        let maxFactor = pow(10,digitCount)-1
        for i in stride(from: maxFactor, through: minFactor, by: -1) {
            for j in stride(from: maxFactor, through: i, by: -1) {
                let prod = i * j
                if prod > best && isPalindrome(digits(prod)) {
                    best = prod
                }
            }
        }
        
        return best // 906609
    }
}