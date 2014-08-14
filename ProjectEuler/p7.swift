//
//  p7.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/7/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p7() -> Int {
        /*
        10001st prime
        Problem 7
        Published on 28 December 2001 at 06:00 pm [Server Time]
        By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
        
        What is the 10 001st prime number?
        
        */
        return primes[10_000]! // 104743
    }
}