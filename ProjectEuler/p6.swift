//
//  p6.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/7/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p6() -> Int {
        /*
        Sum square difference
        Problem 6
        Published on 14 December 2001 at 06:00 pm [Server Time]
        The sum of the squares of the first ten natural numbers is,
        
        1**2 + 2**2 + ... + 10**2 = 385
        The square of the sum of the first ten natural numbers is,
        
        (1 + 2 + ... + 10)**2 = 55**2 = 3025
        Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.
        
        Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
        */
        let count = 100
        let sumOfSquares = Array(1...count).map(square).reduce(0, combine: +)
        let squareOfSum = square((1 + count) * count / 2)
        
        return squareOfSum - sumOfSquares // 25164150
    }
}