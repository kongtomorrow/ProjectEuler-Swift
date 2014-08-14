//
//  p34.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/11/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation


extension Problems {
    func p34() -> Int {
        /*
        145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
        
        Find the sum of all numbers which are equal to the sum of the factorial of their digits.
        
        Note: as 1! = 1 and 2! = 2 are not sums they are not included.
        
        */
        
        // consider adding a digit d to number X to get Xd
        //     Xd == 10*X + d
        //     sum(factorials(digits(Xd))) = sum(factorials(digits(X))) + factorial(d)
        // so,
        var sum = 0
        for i in 3...3628800 {
            if i == digits(i).map(factorial).reduce(0,+) {
                sum += i***
            }
        }
        return sum // 40730
    }
}