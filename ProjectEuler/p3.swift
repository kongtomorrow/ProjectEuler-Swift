//
//  p3.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/6/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p3() -> Int {
        /* Largest prime factor
        Problem 3
        Published on 02 November 2001 at 06:00 pm [Server Time]
        The prime factors of 13195 are 5, 7, 13 and 29.
        
        What is the largest prime factor of the number 600851475143 ?
        */
        let target = 600851475143
        let (p,_) = factor(target).last!
        return p // 6857
    }
}