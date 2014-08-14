//
//  p9.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/7/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p9() -> Int {
        /*
        Special Pythagorean triplet
        Problem 9
        Published on 25 January 2002 at 06:00 pm [Server Time]
        A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
        
        a**2 + b**2 = c**2
        For example, 3**2 + 4**2 = 9 + 16 = 25 = 5**2.
        
        There exists exactly one Pythagorean triplet for which a + b + c = 1000.
        Find the product abc.
        
        */
        let sum = 1000
        for a in 1...sum-2 {
            for b in 1...a {
                let c = sum - (a + b)
                if a*a + b*b == c*c {
                    (a,b,c)*** // (375, 200, 425)
                    return (a*b*c) // 31875000
                }
            }
        }
        return 0
    }
}