//
//  p10.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/7/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p10() -> Int {
        /*
        Summation of primes
        Problem 10
        Published on 08 February 2002 at 06:00 pm [Server Time]
        The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
        
        Find the sum of all the primes below two million.
        
        */
        let limit = 2_000_000
        return primes.takeWhile({$0 < limit})!.foldl(0, merge: +) // 142913828922
    }
}