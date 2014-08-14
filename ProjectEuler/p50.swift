//
//  p50.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/14/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p50() -> Int {
        /*
        Consecutive prime sum
        Problem 50
        
        The prime 41, can be written as the sum of six consecutive primes:
        
        41 = 2 + 3 + 5 + 7 + 11 + 13
        This is the longest sum of consecutive primes that adds to a prime below one-hundred.
        
        The longest sum of consecutive primes below one-thousand that adds to a prime, contains 21 terms, and is equal to 953.
        
        Which prime, below one-million, can be written as the sum of the most consecutive primes?
        */
        
        let r1 : Range = 1...10
        let r : NSRange = NSRange(r1)
        
        let limit = 1_000_000
        var (bestSeqLen, bestSum) = (21, 0)

        var primePartialSums = Array<Int>()
        
        var runningPartialSum = 0
        for p in primes.takeWhile({$0 <= limit / bestSeqLen})! {
            runningPartialSum += p
            primePartialSums.append(runningPartialSum)
        }
        
        let lastInd = primePartialSums.count-1
        nextStartInd: for startInd in 0...lastInd {
            for endInd in stride(from: lastInd, through: startInd+bestSeqLen, by: -1) {
                let sumOfPrimes = primePartialSums[endInd] - primePartialSums[startInd]
                if sumOfPrimes > limit || !isPrime(sumOfPrimes) {
                    continue
                } else {
                    (bestSeqLen,bestSum) = (endInd - startInd, sumOfPrimes)
                    continue nextStartInd
                }
            }
        }
        return bestSum // 997651
    }
}
