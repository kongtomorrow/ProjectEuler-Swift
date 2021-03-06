//
//  main.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 7/29/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p2() -> Int {
        /*
        Even Fibonacci numbers
        Problem 2
        Published on 19 October 2001 at 06:00 pm [Server Time]
        Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:
        
        1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
        
        By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.
        */
        let limit = 4_000_000
        return fibs.filter(isEven)?.takeWhile({ $0 < limit })?.foldl(0, merge: +) ?? 0 // 4613732
    }
}