//
//  p36.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/12/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p36() -> Int {
        /*
        The decimal number, 585 = 10010010012 (binary), is palindromic in both bases.
        
        Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.
        
        (Please note that the palindromic number, in either base, may not include leading zeros.)
        
        */
        let limit = 1_000_000
        return ints.takeWhile({$0 < limit})?.filter({isPalindrome(digits($0)) && isPalindrome(digits($0, base: 2))})?.foldl(0, merge: +) ?? 0 // 872187
    }
}