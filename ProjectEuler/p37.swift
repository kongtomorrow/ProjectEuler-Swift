//
//  p37.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/12/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

private func digitCount(n:Int)->Int {
    return Int(floor(log10(Double(n))))+1
}

private func leftTruncations(n:Int)->GeneratorOf<Int> {
    var cur = n
    return GeneratorOf<Int> {
        if cur < 10 {
            return nil
        } else {
            cur %= pow(10,digitCount(cur)-1)
            return cur
        }
    }
}

private func rightTruncations(n:Int)->GeneratorOf<Int> {
    var cur = n
    return GeneratorOf<Int> {
        if cur < 10 {
            return nil
        } else {
            cur /= 10
            return cur
        }
    }
}

private func isTruncatablePrime(n:Int)->Bool {
    for x in rightTruncations(n) {
        if !isPrime(x) {
            return false
        }
    }
    
    for x in leftTruncations(n) {
        if !isPrime(x) {
            return false
        }
    }
    return true
}

extension Problems {
    func p37() -> Int {
        /*
        The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.
        
        Find the sum of the only eleven primes that are both truncatable from left to right and right to left.
        
        NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
        */
        
        return primes.skip(4)?.filter(isTruncatablePrime)?.take(11)?.foldl(0, merge: +) ?? 0

    }
}
