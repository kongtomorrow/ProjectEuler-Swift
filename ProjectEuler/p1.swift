//
//  p1.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 7/29/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p1() -> Int {
        /*
        Multiples of 3 and 5
        Problem 1
        Published on 05 October 2001 at 06:00 pm [Server Time]
        If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
        
        Find the sum of all the multiples of 3 or 5 below 1000.
        */
        
        let limit = 1_000
        func sumMultsBelowLimit(n:Int)->Int {
            return (n * ints).takeWhile({$0 < limit})!.foldl(0,+)
        }
        return (sumMultsBelowLimit(3) + sumMultsBelowLimit(5) - sumMultsBelowLimit(15)) // 233168
    }
}