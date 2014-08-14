//
//  main.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 8/7/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation
import dispatch

@objc
class Problems {
    
    func methodsStartingWithPrefix(prefix:String)->[String] {
        var count:UInt32 = 0
        let methods = class_copyMethodList(Problems.self, &count)
        var methodNames = [String]()
        for i in 0..<Int(count) {
            let methName = method_getName(methods[i]).description
            methodNames.append(methName)
        }
        free(methods)
        
        return methodNames.filter({($0 as NSString).hasPrefix(prefix)}).sorted({ (a, b) -> Bool in
            return (a as NSString).localizedStandardCompare(b) == NSComparisonResult.OrderedAscending
        })
    }
    
    func benchmarkProblem(methName:String) {
        benchmark(methName) {
            ()->Int in
            return FThePolice.sendProblemMessage(Selector(methName), toObject: self)
        }
    }
}

let probs = Problems()
probs.methodsStartingWithPrefix("p").map({probs.benchmarkProblem($0)})
probs.methodsStartingWithPrefix("run").map({probs.benchmarkProblem($0)})
//probs.benchmarkProblem(probs.methodsStartingWithPrefix("p").last!) // just the last problem
