//
//  p12.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/9/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p12() -> Int {
        /*
        Highly divisible triangular number
        Problem 12
        Published on 08 March 2002 at 06:00 pm [Server Time]
        The sequence of triangle numbers is generated by adding the natural numbers. So the 7th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. The first ten terms would be:
        
        1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
        
        Let us list the factors of the first seven triangle numbers:
        
        1: 1
        3: 1,3
        6: 1,2,3,6
        10: 1,2,5,10
        15: 1,3,5,15
        21: 1,3,7,21
        28: 1,2,4,7,14,28
        We can see that 28 is the first triangle number to have over five divisors.
        
        What is the value of the first triangle number to have over five hundred divisors?
        */
        let divisorLimit = 500
        
        return ints.map(triangleNum).filter({ divisorsCount($0) > divisorLimit })!.car // 76576500
    }
}