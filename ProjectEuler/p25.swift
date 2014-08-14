//
//  p25.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/10/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p25() -> Int {
        /*
        1000-digit Fibonacci number
        Problem 25
        Published on 30 August 2002 at 06:00 pm [Server Time]
        The Fibonacci sequence is defined by the recurrence relation:
        
        Fn = Fn−1 + Fn−2, where F1 = 1 and F2 = 1.
        Hence the first 12 terms will be:
        
        F1 = 1
        F2 = 1
        F3 = 2
        F4 = 3
        F5 = 5
        F6 = 8
        F7 = 13
        F8 = 21
        F9 = 34
        F10 = 55
        F11 = 89
        F12 = 144
        The 12th term, F12, is the first term to contain three digits.
        
        What is the first term in the Fibonacci sequence to contain 1000 digits?
        */
        //Fn is the integer closest to gr^n / sqrt(5)
        // log_10(gr^n / sqrt(5)) = nlog_10(gr)-log_10(sqrt(5))
        // = nlog10(1+sqrt(5)/2) -log_10(sqrt(5))
        // = nlog10(1+sqrt(5)) - nlog10(2) - log10(sqrt(5)
        let desiredDigits = 1000
        
        let goldenRatio = (1.0 + sqrt(5)) / 2
        func digitsOfFib(n:Int) -> Int {
            let digitsDoub = Double(n) * log10(goldenRatio) - log10(sqrt(5)) + 1
            return Int(digitsDoub)
        }
        
        return ints.map(digitsOfFib).takeWhile({$0 < desiredDigits})!.count() + 1
    }
}