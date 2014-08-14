//
//  p23.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/10/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p23() -> Int {
        /*
        Non-abundant sums
        Problem 23
        Published on 02 August 2002 at 06:00 pm [Server Time]
        A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
        
        A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.
        
        As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less than this limit.
        
        Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
        
        */
        let limit = 28123
        func isAbundant(n:Int) -> Bool {
            return properDivisors(n).reduce(0,combine: +) > n
        }
        
        let abundantNums = Array(2...28123).filter(isAbundant)

        var numsPossiblyNotExpressibleAsSumOfAbundants = Array<Bool>(count: limit+1, repeatedValue: true)
        numsPossiblyNotExpressibleAsSumOfAbundants[0] = false // 0 cannot be written as a sum

        for i in 0..<abundantNums.count {
            for j in i..<abundantNums.count {
                let sum = abundantNums[i]+abundantNums[j]
                if sum > limit {
                    break
                }
                numsPossiblyNotExpressibleAsSumOfAbundants[sum] = false
            }
        }
        return ints.takeWhile({$0 <= limit})!.filter({numsPossiblyNotExpressibleAsSumOfAbundants[$0]})!.foldl(0, merge: +)
        
    }
}