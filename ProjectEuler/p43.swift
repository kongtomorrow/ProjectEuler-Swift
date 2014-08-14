//
//  p43.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/13/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    private func bitfieldGen(bitfield:Int, _ availDigits:Int)->GeneratorOf<(Int,Int)> {
        var place = -1
        return GeneratorOf<(Int,Int)> {
            while ++place <= 9 {
                if bitfield & (1 << place) != 0 {
                    return (place, availDigits & ~(1 << place))
                }
            }
            return nil
        }
    }
    
    func p43() -> Int {
        /*
        Sub-string divisibility
        Problem 43
        
        The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.
        
        Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:
        
        d2d3d4=406 is divisible by 2
        d3d4d5=063 is divisible by 3
        d4d5d6=635 is divisible by 5
        d5d6d7=357 is divisible by 7
        d6d7d8=572 is divisible by 11
        d7d8d9=728 is divisible by 13
        d8d9d10=289 is divisible by 17
        Find the sum of all 0 to 9 pandigital numbers with this property.
        */

        var sum = 0
        let availDigits = 0b1111111111
        //d4d5d6=635 is divisible by 5
        let fiveDivisDigits = 0b0000100001
        for (d6,availDigits) in bitfieldGen(0b0000100001,availDigits) {
            //d2d3d4=406 is divisible by 2
            let twoDivisDigits = 0b0101010101
            for (d4,availDigits) in bitfieldGen(twoDivisDigits & availDigits, availDigits) {
                for (d3,availDigits) in bitfieldGen(availDigits, availDigits) {
                    //d3d4d5=063 is divisible by 3
                    let d5Mod3 = (21 - d3 - d4) % 3 // 21 is just a big 0 % 3 num to make sure we get something positive.
                    let threeDivisDigits = 0b1001001001
                    for (d5,availDigits) in bitfieldGen(availDigits & (threeDivisDigits << d5Mod3), availDigits) {
                        //d5d6d7=357 is divisible by 7
                        for (d7, availDigits) in lazy(bitfieldGen(availDigits, availDigits)).filter({(d7:Int,_) in divides(Int(digits: [d5,d6,d7]), 7)}) {
                            //d6d7d8=572 is divisible by 11
                            for (d8, availDigits) in lazy(bitfieldGen(availDigits, availDigits)).filter({(d8:Int,_) in divides(Int(digits:[d6,d7,d8]), 11)}) {
                                //d7d8d9=728 is divisible by 13
                                for (d9, availDigits) in lazy(bitfieldGen(availDigits, availDigits)).filter({(d9:Int,_) in divides(Int(digits:[d7,d8,d9]), 13)}) {
                                    //d8d9d10=289 is divisible by 17
                                    for (d10, availDigits) in lazy(bitfieldGen(availDigits, availDigits)).filter({(d10:Int,_) in divides(Int(digits:[d8,d9,d10]), 17)}) {
                                        for (d2, availDigits) in lazy(bitfieldGen(availDigits, availDigits)) {
                                            for (d1, availDigits) in lazy(bitfieldGen(availDigits, availDigits)) {
                                                sum += Int(digits:[d1,d2,d3,d4,d5,d6,d7,d8,d9,d10])
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return sum
    }
}

