//
//  p28.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/10/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p28() -> Int {
        /*
        Number spiral diagonals
        Problem 28
        Published on 11 October 2002 at 06:00 pm [Server Time]
        Starting with the number 1 and moving to the right in a clockwise direction a 5 by 5 spiral is formed as follows:
        
        21 22 23 24 25
        20  7  8  9 10
        19  6  1  2 11
        18  5  4  3 12
        17 16 15 14 13
        
        It can be verified that the sum of the numbers on the diagonals is 101.
        
        What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed in the same way?
        
        */
        let dim = 1001
        
        func spiralEntryAt(x:Int, y:Int) -> Int {
            let ring = max(abs(x),abs(y))
            let armLength = ring*2
            
            var lastArmPartial = 0
            var arm = 0
            switch (x,y) {
            case (ring, let row) where row != ring:
                arm = 0
                lastArmPartial = ring - y
            case (_,-ring):
                arm = 1
                lastArmPartial = armLength - (x + ring)
            case (-ring,_):
                arm = 2
                lastArmPartial = y + ring
            default:
                arm = 3
                lastArmPartial = x + ring
            }
            let prevRingSideLen = (ring-1)*2 + 1
            return prevRingSideLen*prevRingSideLen + arm*armLength + lastArmPartial
        }
        
        let maxRing :Int = dim/2
        let rings : [Int] = Array(1...maxRing)
        return rings.flatmap { (ring) -> [(Int,Int)] in
            return cartesianProduct([-ring,ring],[-ring,ring])
        }.map(spiralEntryAt).reduce(1, combine: +) // 669171001

    }
}