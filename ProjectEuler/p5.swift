//
//  p5.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/7/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p5() -> Int {
        /*
        Smallest multiple
        Problem 5
        Published on 30 November 2001 at 06:00 pm [Server Time]
        2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
        
        What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
        
        */
        let limit = 20
        return  unfactor(Array(2...limit).map(factor).reduce(Factors(), combine: max)) // 232792560
    }
}