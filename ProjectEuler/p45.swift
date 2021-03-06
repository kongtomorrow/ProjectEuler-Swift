//
//  p45.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/14/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p45() -> Int {
        /*
        Triangular, pentagonal, and hexagonal
        Problem 45
        
        Triangle, pentagonal, and hexagonal numbers are generated by the following formulae:
        
        Triangle	 	Tn=n(n+1)/2	 	1, 3, 6, 10, 15, ...
        Pentagonal	 	Pn=n(3n−1)/2	 	1, 5, 12, 22, 35, ...
        Hexagonal	 	Hn=n(2n−1)	 	1, 6, 15, 28, 45, ...
        It can be verified that T285 = P165 = H143 = 40755.
        
        Find the next triangle number that is also pentagonal and hexagonal.
        */
        
        return ints.skip(143)?.map(hexagonalNum).filter(isPentagonalNum)?.filter(isTriangleNum)?.car ?? 0
            
    }
}

