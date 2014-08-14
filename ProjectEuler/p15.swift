//
//  p15.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/9/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    
    func p15() -> Int {
        /*
        Lattice paths
        Problem 15
        Published on 19 April 2002 at 06:00 pm [Server Time]
        Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.
        
        
        How many such routes are there through a 20×20 grid?
        */
        
        // we make gridSize moves right and gridSize moves down, and every order of picking is different.
        // that's 2*gridSize choose gridSize.
        // numbers are too large to compute the factorials straight out though
        let gridSize = 20
        return combinations(gridSize*2, gridSize) // 137846528820
    }
}