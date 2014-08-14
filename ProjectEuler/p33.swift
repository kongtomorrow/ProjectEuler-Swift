//
//  p33.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/11/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p33() -> Int {
        /*
        The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.
        
        We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
        
        There are exactly four non-trivial examples of this type of fraction, less than one in value, and containing two digits in the numerator and denominator.
        
        If the product of these four fractions is given in its lowest common terms, find the value of the denominator.
        */
        
        func makeRatl(num10s:Int,num1s:Int,den10s:Int,den1s:Int) -> (Int,Int) {
            return (num10s*10 + num1s, den10s*10+den1s)
        }
        
        func reduceFraction(numer:Int, denom:Int)->(Int,Int) {
            var numerFactors = Factors()
            var denomFactors = Factors()
            for (p,power) in componentwiseOp(factor(numer), factor(denom), -) {
                if power > 0 {
                    let term = (p,power)
                    numerFactors.append(term)
                } else {
                    let term = (p,-power)
                    denomFactors.append(term)
                }
            }
            return (unfactor(numerFactors), unfactor(denomFactors))
        }
        
        var nProd = 1
        var dProd = 1
        for repeatedDigit in 1...9 {
            for numDigit in 1...9 {
                for denDigit in 1...9 {
                    for (n,d) in [makeRatl(numDigit, repeatedDigit, denDigit, repeatedDigit),
                        makeRatl(numDigit, repeatedDigit, repeatedDigit, denDigit),
                        makeRatl(repeatedDigit, numDigit, denDigit, repeatedDigit),
                        makeRatl(repeatedDigit, numDigit, repeatedDigit, denDigit)] {
                            if (n < d) {
                                if reduceFraction(n, d) == reduceFraction(numDigit, denDigit) {
                                    "\(n)/\(d) == \(numDigit)/\(denDigit)"***
                                    nProd *= numDigit
                                    dProd *= denDigit
                                }
                            }
                    }
                }
            }
        }
        let (_, res) = reduceFraction(nProd, dProd)
        return res
    }
}