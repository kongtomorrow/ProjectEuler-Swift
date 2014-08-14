//
//  p24.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/10/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

// compiler bug with nested functions
private func lexicographicPermutation(n:Int, els:[Int]) -> [Int] {
    if els.count == 1 {
        return els
    }
    let totalPerms = factorial(els.count)
    let chunkSize : Int = totalPerms / els.count
    let chunk :Int = n / chunkSize
    var newEls = els
    newEls.removeAtIndex(chunk)
    
    return  [els[chunk]] + lexicographicPermutation(n - chunk*chunkSize, newEls)
}

extension Problems {
    func p24() -> Int {
        /*
        Lexicographic permutations
        Problem 24
        Published on 16 August 2002 at 06:00 pm [Server Time]
        A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
        
        012   021   102   120   201   210
        
        What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
        */
        
        return Int(digits:lexicographicPermutation(1000000-1, [0,1,2,3,4,5,6,7,8,9])) // 2783915460
    }
}