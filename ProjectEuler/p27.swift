//
//  p27.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/10/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p27() -> Int {
        /*
        Euler discovered the remarkable quadratic formula:
        
        n² + n + 41
        
        It turns out that the formula will produce 40 primes for the consecutive values n = 0 to 39. However, when n = 40, 402 + 40 + 41 = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41² + 41 + 41 is clearly divisible by 41.
        
        The incredible formula  n² − 79n + 1601 was discovered, which produces 80 primes for the consecutive values n = 0 to 79. The product of the coefficients, −79 and 1601, is −126479.
        
        Considering quadratics of the form:
        
        n² + an + b, where |a| < 1000 and |b| < 1000
        
        where |n| is the modulus/absolute value of n
        e.g. |11| = 11 and |−4| = 4
        Find the product of the coefficients, a and b, for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n = 0.
        
        */
        
        let intsWithZero = Stream(0,ints)
        func primeRunLen(a:Int, b:Int) -> Int{
            func evalPoly(n:Int)->Int {
                return (n+a)*n + b
            }

            return intsWithZero.map(evalPoly).takeWhile(isPrime)?.count() ?? 0
        }
        
        var (maxA,maxB,maxRun) = (0,0,0)
        for b in primes.takeWhile({$0 < 1000})! {
            for a in -999...999 {
                let run = primeRunLen(a, b)
                if  run > maxRun {
                    (maxA,maxB,maxRun) = (a,b,run)
                }
            }
        }
        return (maxA*maxB) // -59231
    }
}