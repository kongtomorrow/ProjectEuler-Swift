//
//  p48.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/14/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p48() -> Int {
        /*
        Self powers
        Problem 48
        
        The series, 1**1 + 2**2 + 3**3 + ... + 10**10 = 10405071317.
        
        Find the last ten digits of the series, 1**1 + 2**2 + 3**3 + ... + 1000**1000.
        */
        let modulus = pow(10, 10)
        return (1...1000).map({powmod($0, $0, modulus)}).reduce(0, combine: {($0 + $1) % modulus})
    }
}

