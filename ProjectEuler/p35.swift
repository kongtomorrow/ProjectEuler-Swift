//
//  p35.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/12/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p35() -> Int {
        /*
        The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.
        
        There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.
        
        How many circular primes are there below one million?
        */
        
        let limit = 1_000_000
        let circularPrimes = primes.takeWhile({$0 < limit})?.filter { (n:Int)->Bool in
            let nDigits = digits(n)
            // quick filter - knock out anything containing an even number or a five
            if digitsToBitfield(nDigits) & UInt(0b0101110100) != 0 && n != 2 && n != 5{
                return false
            } else {
                let digitCount = nDigits.count
                let topDigitMultiplier = pow(10,digitCount-1)
                var rotation = n
                for i in 0..<digitCount {
                    if !isPrime(rotation) {
                        return false
                    }
                    rotation /= 10
                    rotation += topDigitMultiplier*nDigits[i]
                }
                return true
            }
        }
        
        return circularPrimes?.count() ?? 0
    }
}