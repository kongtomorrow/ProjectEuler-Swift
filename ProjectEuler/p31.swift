//
//  p31.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/11/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

private let coins = [1,2,5,10,20,50,100,200]
private func waysToMakeChange(pence:Int, usingCoinsFromIndex coinIndex:Int = 0) -> Int {
    if pence == 0 {
        return 1
    }
    if coinIndex >= coins.count || pence < 0 {
        return 0
    }
    let coinVal = coins[coinIndex]
    return waysToMakeChange(pence-coinVal, usingCoinsFromIndex:coinIndex) + waysToMakeChange(pence, usingCoinsFromIndex:coinIndex+1)
}

extension Problems {
    func p31() -> Int {
        /*
        problem 31
        
        In England the currency is made up of pound, £, and pence, p, and there are eight coins in general circulation:
        
        1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
        It is possible to make £2 in the following way:
        
        1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
        How many different ways can £2 be made using any number of coins?
        */
        return waysToMakeChange(200)
    }
}