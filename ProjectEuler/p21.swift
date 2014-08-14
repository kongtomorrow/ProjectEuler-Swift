//
//  p21.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/10/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p21() -> Int {
        /*
        Amicable numbers
        Problem 21
        Published on 05 July 2002 at 06:00 pm [Server Time]
        Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
        If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.
        
        For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
        
        Evaluate the sum of all the amicable numbers under 10000.
        
        */
        let limit = 10_000
        
        func isAmicable(n:Int)->Bool {
            func sumOfDivisors(m:Int) -> Int {
                return properDivisors(m).reduce(0, combine: +)
            }
            let candidatePartner = sumOfDivisors(n)
            return candidatePartner != n && sumOfDivisors(candidatePartner) == n
        }
        
        return Array(2..<limit).filter(isAmicable).reduce(0, combine: +) // 31626
    }
}