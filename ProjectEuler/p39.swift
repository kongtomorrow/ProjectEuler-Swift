//
//  p39.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/12/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p39() -> Int {
        /*
        If p is the perimeter of a right angle triangle with integral length sides, {a,b,c}, there are exactly three solutions for p = 120.
        
        {20,48,52}, {24,45,51}, {30,40,50}
        
        For which value of p ≤ 1000, is the number of solutions maximised?
        */
        var (maxVotes, maxPerim) = (0,0)
        var votes = Array<Int>(count: 1001, repeatedValue: 0)
        for a in 1...500 {
            for b in 1..<a {
                let aSquaredPlusBSquared = a*a + b*b
                let c = Int(round(sqrt(Double(aSquaredPlusBSquared))))
                if c*c == aSquaredPlusBSquared {
                    // found a right triangle
                    let perim = a+b+c
                    if perim <= 1000 {
                        if ++votes[perim] > maxVotes {
                            (maxVotes,maxPerim) = (votes[perim], perim)
                        }
                    }
                }
            }
        }
        return maxPerim // 840
    }
}
