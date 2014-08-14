//
//  p32.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/11/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p32() -> Int {
        /* problem 32
        We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1 through 5 pandigital.
        
        The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier, and product is 1 through 9 pandigital.
        
        Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.
        
        HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.
        */
                
        func isPanDigital(m1:Int, m2:Int, prod:Int) -> (Bool,Bool) {
            let digs = map((m1,m2,prod),digits)
            let count = reduce(map(digs, countElements),0,+)
            if count != 9 {
                return (false,count<9)
            }
            let digitsBitfield = reduce(map(digs,digitsToBitfield),0,|)
            if (digitsBitfield == 0b1111111110) {
                return (true,true)
            } else {
                return (false,true)
            }
        }
        
        // digit count of prod is at least as much as m1 and m2.
        // so if either m1 or m2 has 5 digits, sum of all #digits will be at least 10
        // so m1 and m2 are fewer than 5 digits
        var allProds = [:] as [Int:Bool]
        for m1 in 1...10000 {
            for m2 in 1...10000 {
                let prod = m1*m2
                let (isPan, keepGoing) = isPanDigital(m1, m2, m1*m2)
                if isPan {
                    allProds[prod] = true
                }
                if !keepGoing {
                    break
                }
            }
        }
        return Array(allProds.keys).reduce(0, combine: +)
    }
}