//
//  p19.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/9/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

extension Problems {
    func p19() -> Int {
        /*
        Counting Sundays
        Problem 19
        Published on 14 June 2002 at 06:00 pm [Server Time]
        You are given the following information, but you may prefer to do some research for yourself.
        
        1 Jan 1900 was a Monday.
        Thirty days has September,
        April, June and November.
        All the rest have thirty-one,
        Saving February alone,
        Which has twenty-eight, rain or shine.
        And on leap years, twenty-nine.
        A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
        How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?
        */
        
        enum Day : Int, Printable {
            case Monday
            case Tuesday
            case Wednesday
            case Thursday
            case Friday
            case Saturday
            case Sunday
            
            func advanceBy(days:Int)->Day {
                return Day.fromRaw((self.toRaw() + days) % 7)!
            }
            
            var description : String {
                return self.toRaw().description
            }
        }
        
        enum Month : Int, Printable {
            case January
            case February
            case March
            case April
            case May
            case June
            case July
            case August
            case September
            case October
            case November
            case December
            
            func days(year:Int) -> Int {
                switch self {
                case .September, .April, .June, .November:
                    return 30
                case .January, .March, .May, .July, .August, .October, .December:
                    return 31
                case .February:
                    if divides(year, 4) && (!divides(year, 100) || divides(year, 400)) {
                        return 29
                    } else {
                        return 28
                    }
                }
            }
            
            func advance()->Month {
                return Month.fromRaw((self.toRaw() + 1) % 12)!
            }
            
            var description : String {
                return self.toRaw().description
            }
        }
        
        func advanceByMonth(day:Day, month:Month, year:Int)->(Day,Month,Int) {
            let newDay = day.advanceBy(month.days(year))
            let newMonth = month.advance()
            let newYear = (newMonth == .January) ? year+1 : year
            return (newDay, newMonth, newYear)
        }

        var sundaysCount = 0
        var (day, month, year) = (Day.Monday, Month.January, 1900)
        while year < 2001 {
            (day, month, year) = advanceByMonth(day, month, year)
            if year >= 1901 && day == .Sunday {
                sundaysCount++
            }
        }
        
        return sundaysCount
    }
}