//
//  p47.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/14/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p47() -> Int {
        /*
        Distinct primes factors
        Problem 47
        Published on 04 July 2003 at 06:00 pm [Server Time]
        The first two consecutive numbers to have two distinct prime factors are:
        
        14 = 2 × 7
        15 = 3 × 5
        
        The first three consecutive numbers to have three distinct prime factors are:
        
        644 = 2² × 7 × 23
        645 = 3 × 5 × 43
        646 = 2 × 17 × 19.
        
        Find the first four consecutive integers to have four distinct prime factors. What is the first of these numbers?
        */
        let numFactors = 4
        
        for i in 1..<Int.max {
            let probe = i*numFactors
            if factor(probe).count == numFactors {
                var last = probe
                var first = probe
                for next in probe+1...probe+numFactors-1 {
                    if factor(next).count == numFactors {
                        last++
                    } else {
                        break
                    }
                }
                for prev in stride(from: probe-1, through: probe-3, by: -1) {
                    if factor(prev).count == numFactors {
                        first--
                    } else {
                        break
                    }
                }
                if last-first >= numFactors-1 {
                    return first // 134043
                }
            }
        }
        return 0
    }
}

