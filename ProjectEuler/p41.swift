//
//  p41.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/13/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p41() -> Int {
        /*
        We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is also prime.
        
        What is the largest n-digit pandigital prime that exists?
        
        */
        var best = 0
        for digCount in stride(from: 9, through: 1, by: -1) {
            for perm in permutationsGen(Array(1...digCount)) {
                let n = Int(digits: perm)
                if isPrime(n) {
                    best = max(best, n)
                }
            }
            if best != 0 {
                break
            }
        }
        return best
    }
}
