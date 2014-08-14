//
//  p14.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/9/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {

    func p14() -> Int {
        /*
        Longest Collatz sequence
        Problem 14
        Published on 05 April 2002 at 06:00 pm [Server Time]
        The following iterative sequence is defined for the set of positive integers:
        
        n → n/2 (n is even)
        n → 3n + 1 (n is odd)
        
        Using the rule above and starting with 13, we generate the following sequence:
        
        13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
        It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.
        
        Which starting number, under one million, produces the longest chain?
        
        NOTE: Once the chain starts the terms are allowed to go above one million.
        */
        let limit = 1_000_000
        
        func collatzSeq(seed:Int)->GeneratorOf<Int> {
            var cur : Int? = seed
            return GeneratorOf<Int> {
                switch cur! {
                case 1: cur = nil
                case let n where n % 2 == 0: cur = n/2
                case let n: cur = 3 * n + 1
                }
                return cur
            }
        }
        
        // you'd think it'd be better to memoize rather than compute each sequence from scratch, but that's not what I'm getting
        func lenCollatzSeq(seed:Int)->Int {
            var i = 1
            for _ in collatzSeq(seed) {
                i++
            }
            return i
        }
        
        var (maxSeed,maxLen) = (0,0)
        for seed in 1..<limit {
            if lenCollatzSeq(seed) > maxLen {
                (maxSeed,maxLen) = (seed,lenCollatzSeq(seed))
            }
        }
        
        return maxSeed
    }

}