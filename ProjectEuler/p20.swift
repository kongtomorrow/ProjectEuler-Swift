//
//  p20.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/10/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    
    func p20() -> Int {
        /*
        Factorial digit sum
        Problem 20
        Published on 21 June 2002 at 06:00 pm [Server Time]
        n! means n × (n − 1) × ... × 3 × 2 × 1
        
        For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
        and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
        
        Find the sum of the digits in the number 100!
        */
        let target = 100
        return Array(1...target).reduce(digits(1), combine: { digits($0, timesCoefficient: $1) }).reduce(0, combine: +) // 648
    }
}