//
//  p49.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/14/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

func uniq<T:Equatable>(inout arr:[T]) {
    for i in stride(from: arr.count-2, through: 0, by: -1) {
        if arr[i] == arr[i+1] {
            arr.removeAtIndex(i)
        }
    }
}

extension Problems {
    func p49() -> Int {
        /*
        Prime permutations
        Problem 49
        Published on 01 August 2003 at 06:00 pm [Server Time]
        The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases by 3330, is unusual in two ways: 
        (i) each of the three terms are prime, and, 
        (ii) each of the 4-digit numbers are permutations of one another.
        
        There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes, exhibiting this property, but there is one other 4-digit increasing sequence.
        
        What 12-digit number do you form by concatenating the three terms in this sequence?
        */
        
        let isFourDigit:Int->Bool = { 1000..<10000 ~= $0 }
        
        for p in primes.filter(isFourDigit)! {
            var primePerms = Array(permutationsGen(digits(p))).map({Int(digits: $0)}).filter(isPrime).filter(isFourDigit)
            sort(&primePerms)
            uniq(&primePerms)
            if primePerms[0] == 1487 {
                continue
            }
            for i in 0..<primePerms.count {
                for j in i+1..<primePerms.count {
                    let (a,b) = (primePerms[i], primePerms[j])
                    let delta = b - a
                    let c = b + delta
                    if contains(primePerms, c) {
                        (a,b,c,delta)***
                        return Int(digits:reduce(map((a,b,c), {reverse(digits($0))}), [Int](), +)) // 296962999629
                    }
                }
            }
        }
        return 0
    }
}

