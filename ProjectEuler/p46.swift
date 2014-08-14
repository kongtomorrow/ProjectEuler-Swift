//
//  p46.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/14/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p46() -> Int {
        /*
        Goldbach's other conjecture
        Problem 46
        
        It was proposed by Christian Goldbach that every odd composite number can be written as the sum of a prime and twice a square.
        
        9 = 7 + 2×12
        15 = 7 + 2×22
        21 = 3 + 2×32
        25 = 7 + 2×32
        27 = 19 + 2×22
        33 = 31 + 2×12
        
        It turns out that the conjecture was false.
        
        What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?
        */
        
        let squares = ints.map(square)
        
        func passesConjecture(n:Int) -> Bool {
            if isPrime(n) {
                return true
            }
            for sq in squares {
                let p = n - 2*sq
                if p <= 0 {
                    return false
                } else if isPrime(p) {
                    return true
                }
            }
            return false
        }
        
        let odds = ints.map({2 * $0 - 1})
        return odds.cdr!.filter({!passesConjecture($0)})!.car // 5777
    }
}

