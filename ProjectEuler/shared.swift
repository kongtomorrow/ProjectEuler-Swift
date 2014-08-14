//
//  main.swift
//  ProjectEuler
//
//  Created by Ken Ferry on 7/29/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

import Foundation

// MARK: -
// MARK: Utility
// MARK: -

// logging
postfix operator *** { }
postfix func ***<T>(obj:T) -> T { println(obj); return obj }

func benchmark<T>(label:String, body:()->T)->T {
    var info = mach_timebase_info_data_t(numer: 0, denom: 0)
    mach_timebase_info(&info)
    
    let tick = mach_absolute_time()
    let res = body()
    let tock = mach_absolute_time()
    let delta = tock - tick
    
    let nanos = delta * UInt64(info.numer) / UInt64(info.denom)
    let seconds = Double(nanos) / Double(NSEC_PER_SEC)
    

    "\(label) returned \(res) in \(seconds) seconds"***
    return res
}

// pointer

class Ptr<T> {
    let val : T
    init(_ aVal:T) {
        val = aVal
    }
}

// for switching on
//func compare(a:Int, b:Int)->NSComparisonResult {
//    if a == b {
//        return .OrderedSame
//    } else if a < b {
//        return .OrderedAscending
//    } else {
//        return .OrderedDescending
//    }
//}

var logCacheMiss = false
var cacheMissDepth = 0
func memoize<S:Hashable,T>(f:S->T) ->S->T {
    var cache = [S:T]()
    return {
        (args:S)->T in
        var res = cache[args]
        if res == nil {
            if logCacheMiss {
                for i in 0..<cacheMissDepth {
                    print("  ")
                }
                print("depth:\(cacheMissDepth) -- memoized cache will miss!\n")
            }
            res = f(args)
            cache[args] = res
            if logCacheMiss {
                for i in 0..<cacheMissDepth {
                    print("  ")
                }
                print("depth:\(cacheMissDepth) -- memoized cache did miss \(res)!\n")
            }
        }
        return res!
    }
}

// void isn't hashable, so not covered above
func memoize<T>(f:()->T) ->()->T {
    var cache : T? = nil
    return {
        if cache == nil {
            if logCacheMiss {
                for i in 0..<cacheMissDepth {
                    print("  ")
                }
                dump(nil as T?, name: "will miss cache", indent: cacheMissDepth, maxDepth: 100, maxItems: 10)
                cacheMissDepth++
            }
            cache = f()
            if logCacheMiss {
                cacheMissDepth--
                for i in 0..<cacheMissDepth {
                    print("  ")
                }
                dump(cache, name: "did miss cache", indent: cacheMissDepth, maxDepth: 100, maxItems: 10)
            }
        }
        return cache!
    }
}

func denseMemoize<T>(f:Int->T) ->Int->T {
    var cache = [Optional<T>.None]
    return {
        (i:Int)->T in
        while i >= cache.count {
            cache.extend(Repeat(count: cache.count, repeatedValue: Optional<T>.None))
        }
        
        var res = cache[i]
        if res == nil {
            if logCacheMiss {
                for i in 0..<cacheMissDepth {
                    print("  ")
                }
                print("depth:\(cacheMissDepth) -- memoized cache will miss!\n")
            }
            res = f(i)
            cache[i] = res
            if logCacheMiss {
                for i in 0..<cacheMissDepth {
                    print("  ")
                }
                print("depth:\(cacheMissDepth) -- memoized cache did miss \(res)!\n")
            }
        }
        return res!
    }
}

func fix<D,R>(almost:(D->R)->(D->R))->(D->R) {
    return almost {(args:D)->R in
        return fix(almost)(args)
    }
}


// delay/force
struct Delay<T> {
    let _val:()->T
    init(_ val: @autoclosure ()->T) {
        _val = memoize(val)
    }
    
    init(_ val:()->T) {
        _val = memoize(val)
    }

    func force()->T {
        return _val()
    }
}

extension Optional {
    func chain<U>(f:T->U?)->U? {
        switch self {
        case .None: return nil
        case let .Some(x): return f(x)
        }
    }
}

extension Array {
    func flatmap<U>(transform: (T) -> [U]) -> [U] {
        return map(transform).reduce(Array<U>(), combine: +)
    }
}

func map<T,S>(tup:(T,T), f:T->S)->(S,S) {
    let (a,b) = tup
    return (f(a),f(b))
}

func map<T,S>(tup:(T,T,T), f:T->S)->(S,S,S) {
    let (a,b,c) = tup
    return (f(a),f(b),f(c))
}

func map<T,S>(tup:(T,T,T,T), f:T->S)->(S,S,S,S) {
    let (a,b,c,d) = tup
    return (f(a),f(b),f(c),f(d))
}

func reduce<T,S>(tup:(T,T), ini:S, f:(S,T)->S)->S {
    let (a,b) = tup
    return f(f(ini,a),b)
}

func reduce<T,S>(tup:(T,T,T), ini:S, f:(S,T)->S)->S {
    let (a,b,c) = tup
    return f(f(f(ini,a),b),c)
}

func reduce<T,S>(tup:(T,T,T,T), ini:S, f:(S,T)->S)->S {
    let (a,b,c,d) = tup
    return f(f(f(f(ini,a),b),c),d)
}

func ==<T1:Equatable,T2:Equatable>(x:(T1,T2), y:(T1,T2))->Bool {
    let (x1,x2) = x
    let (y1,y2) = y
    return x1 == y1 && x2 == y2
}

func ==<T1:Equatable,T2:Equatable,T3:Equatable>(x:(T1,T2,T3), y:(T1,T2,T3))->Bool {
    let (x1,x2,x3) = x
    let (y1,y2,y3) = y
    return x1 == y1 && x2 == y2 && x3 == y3
}



// MARK: -
// MARK: Flow Control / Data Structures
// MARK: -


// FIXME: Should be Stream<T>, but hitting bugs in Swift seed 5
struct Stream : Printable, SequenceType {
    let _car : Int
    let _cdr : ()->Stream?
    
    var car : Int { get { return _car } }
    var cdr : Stream? {
        return _cdr()
    }
    
    init(_ car:Int, _ cdr:@autoclosure ()->Stream?) {
        _car = car
        _cdr = memoize(cdr)
    }
    
    static func streamWith(next:()->Int?)->Stream? {
        switch next() {
        case .None: return nilStream
        case let .Some(el): return Stream(el, Stream.streamWith(next))
        }
    }
    
    static func streamWith<Seq:SequenceType where Seq.Generator.Element == Int>(seq:Seq)->Stream? {
        var gen = seq.generate()
        let next = {()->Int? in return gen.next() }
        return streamWith(next)
    }
    
    func generate() -> GeneratorOf<Int> {
        var nextStream:()->Stream? = {self}
        return GeneratorOf<Int> {
            if let cur = nextStream() {
                let el = cur.car
                nextStream = cur._cdr
                return el
            } else {
                return nil
            }
        }
    }
    
    func map(f:Int->Int)->Stream {
        return Stream(f(car), cdr?.map(f))
    }
    
    func foldr<S>(merge:(Int, @autoclosure()->S)->S)->S {
        assert(cdr != nil, "foldr hit the end of the stream!")
        return merge(car, cdr!.foldr(merge))
    }
    
    func foldl<S>(ini:S, merge:(S,Int)->S)->S {
        // recursive version wasn't tail calling
        // we pass self.generate() rather than self here because reduce will retain the entire stream if you pass self
        // this can lead to a stack overflow when the stream is deallocated, as the deallocation of each cell calls deallocation of the next
        // side note: large streams must be deallocated as you go or never! if you try to kill it all at once, overflow.
        return reduce(self.generate(), ini, merge)
    }
    
    func count()->Int {
        return foldl(0, merge: { (countSoFar:Int, _) -> Int in
            return countSoFar + 1
        })
    }

    // index of first match
    func find(pred:Int->Bool)->Int {
        return takeWhile({!pred($0)})?.count() ?? 0
    }

    func takeWhile(pred:Int->Bool)->Stream? {
        if pred(car) {
            return Stream(car, cdr.chain({$0.takeWhile(pred)}))
        } else {
            return nil
        }
    }
    
    func take(n:Int)->Stream? {
        switch n {
        case 0: return nil
        case 1: return Stream(car,nilStream)
        default:
            return Stream(car, cdr?.take(n-1))
        }
    }


    func skip(n:Int)->Stream? {
        switch n {
        case 0: return self
        case _: return cdr?.skip(n-1)
        }
    }
    
    var last : Int {
        switch cdr {
            case .None: return car
            case let .Some(next): return next.last
        }
    }
    
    func filter(pred:Int->Bool)-> Stream?{
        // not tail calling as required
        //        if pred(car) {
        //            return Stream(car, cdr?.filter(pred))
        //        } else {
        //            return cdr?.filter(pred)
        //        }
        return Stream.streamWith(lazy(self).filter(pred))
    }
    
    func uniq()-> Stream?{
        var prev : Int? = nil
        return self.filter {
            if ($0 == prev) {
                return false
            } else {
                prev = $0
                return true
            }
        }
    }

    
    func interleave(other:Stream?) -> Stream {
        return Stream(car, other?.interleave(cdr) ?? cdr)
    }
    
    subscript (r:Range<Int>)->Stream? {
        switch (r.startIndex, r.endIndex) {
            case (0,0):return nil
            case let (0,end): return Stream(car,cdr?[Range(start: 0, end: end-1)])
            case let (start,end): return cdr?[Range(start: start-1, end: end-1)]
        }
    }
    
    subscript (i: Int) -> Int? {
            switch i {
                case 0: return car
                case _: return cdr?[i-1]
            }
    }
    
    var description : String {
        return Array(self[0...4]!).description
    }
}

func +(s1:Stream?, s2:Stream?) -> Stream? {
    if s1 == nil {
        return s2
    } else if s2 == nil {
        return s1
    } else {
        return Stream(s1!.car + s2!.car, s1!.cdr + s2!.cdr)
    }
}

func *(coeff:Int, s:Stream) -> Stream {
    return Stream(coeff * s.car, coeff * s.cdr)
}

func *(coeff:Int, optS:Stream?) -> Stream? {
    if let s = optS {
        return coeff * s
    } else {
        return nil
    }
}

func *(optS:Stream?, coeff:Int) -> Stream? {
    return coeff * optS
}

func *(s:Stream, coeff:Int) -> Stream? {
    return coeff * s
}

// boo, crashing the compiler
func mergeSortedStreams(s1:Stream?, s2:Stream?, op:(Int?,Int?)->Int?)->Stream? {
    switch (s1?.car, s2?.car) {
    case (nil,nil):
        return nilStream
    case let (.Some(s1car), s2car) where s2car == nil || s1car < s2car!:
        let next = { mergeSortedStreams(s1?.cdr, s2, op) }
        if let el = op(s1car, nil) {
            return Stream(el, next())
        } else {
            return next()
        }

    case let (s1car, .Some(s2car)) where s1car == nil || s2car < s1car!:
        let next = {mergeSortedStreams(s1, s2?.cdr, op)}
        if let el = op(nil, s2car) {
            return Stream(el, next())
        } else {
            return next()
        }
    default:
        // this should be a case statement above, but compiler is crashing
//    case let (.Some(s1car), .Some(s2car)) where s1car == s2car:
        let next = {mergeSortedStreams(s1?.cdr, s2?.cdr, op)}
        if let el = op(s1!.car, s1!.car) {
            return Stream(el, next())
        } else {
            return next()
        }

    }
}


// WARNING: not sure I want to keep this
struct StreamGen<T> : GeneratorType {
    var thunk:()->(val:T?,next:StreamGen<T>)
    
    mutating func next() -> T? {
        let (val,next) = thunk()
        thunk = next.thunk
        return val
    }
    
    init(thunk aThunk:()->(val:T?,next:StreamGen<T>)) {
        thunk = aThunk
    }
    
    init<Gen:GeneratorType where Gen.Element == T>(inout gen:Gen) {
        thunk = {
            return (gen.next(), StreamGen(gen: &gen))
        }
    }
}

func cartesianProduct<E1, E2>(s1:[E1], s2:[E2]) -> Array<(E1,E2)> {
    var productArray = Array<(E1,E2)>()
    productArray.reserveCapacity(s1.count*s2.count)
    for e1 in s1 {
        for e2 in s2 {
            let pair = (e1,e2)
            productArray.append(pair)
        }
    }
    return productArray
}

func cartesianProduct<E1, E2>(s1:Range<E1>, s2:Range<E2>) -> Array<(E1,E2)> {
    return cartesianProduct(Array(s1), Array(s2))
}

//
//func cartesianProduct<Seq1:SequenceType,Seq2:SequenceType>(seq1:Seq1, seq2:Seq2) -> GeneratorOf<(Seq1.Generator.Element,Seq2.Generator.Element)> {
//    typealias E1 = Seq1.Generator.Element
//    typealias E2 = Seq2.Generator.Element
//    var seq1Gen = seq1.generate()
//    var liveSeq2Generators = Array<(E1,()->E2)>()
//    var col = 0
//    return GeneratorOf<(E1,E2)> {
//        while true {
//            if col >= liveSeq2Generators.count {
//                if let nextE1 = seq1Gen.next() {
//                    liveSeq2Generators.append( (nextE1,seq2.generate().next) )
//                    col = 0
//                } else if col > 0 {
//                    col = 0
//                } else {
//                    return nil
//                }
//            }
//            
//            let (e1, e2nextFunc) = liveSeq2Generators[col]
//            if let e2 = e2nextFunc() {
//                col++
//                return (e1, e2)
//            } else {
//                liveSeq2Generators.removeAtIndex(col)
//            }
//        }
//    }
//}



//class IntSeq : Swift.Sequence {
//    let _subscriptFunc:(Int)->Int
//    var _cacheGen : GeneratorOf<Int>
//    var _cache = NSMutableIndexSet(index:0)
//    
//    init(subscriptFunc:(Int)->Int) {
//        _subscriptFunc = subscriptFunc
//        _cacheGen = subscriptGen(_subscriptFunc)
//    }
//    
//    convenience init<G:GeneratorType where G.Element == Int>(gen:G) {
//        var gen2 = gen
//        var array = [Int]()
//        self.init(subscriptFunc:{
//            (i:Int)->Int in
//            while i >= array.count {
//                if let el = gen2.next() {
//                    array.append(el)
//                } else {
//                    break
//                }
//            }
//            return array[i]
//        })
//    }
//    
//    convenience init<Seq:SequenceType where Seq.Generator.Element == Int>(seq:Seq) {
//        var gen = seq.generate()
//        self.init(gen: gen)
//    }
//
//    
//    subscript (i: Int) -> Int { get {return _subscriptFunc(i)} }
//    func generate()-> GeneratorOf<Int> {
//        return subscriptGen(_subscriptFunc)
//    }
//    
//    func contains(n:Int) -> Bool {
//        while n > _cache.lastIndex {
//            _cache.addIndex(_cacheGen.next()!)
//        }
//        return _cache.containsIndex(n)
//    }
//}

// MARK: -
// MARK: Useful Streams
// MARK: -


// a hack to allow referring to a var in its own definition
//
//   let ones = Stream(1, ones)
//
// can be written as
//
//   let ones : Stream = fixVar {
//     Stream(1, $0())
//   }
//
// . $0() is the var being defined.
func fixVar<T>(lazySelf:(()->T)->T)->T {
    var _tmp:T! = nil
    _tmp = lazySelf({_tmp})
    return _tmp
}

let nilStream = nil as Stream?

let ones : Stream = fixVar {
    Stream(1, $0())
}

let ints : Stream = fixVar {
    Stream(1, $0() + ones)
}

let fibs = fixVar {
    Stream(1, Stream(2, $0() + $0().cdr))
}


// I like the simple implementation, but the other is a lot faster
#if slowCleanPrimes
    let primes = Stream(2, (2 * ints + ones)?.filter(isPrime))
    #else
    var _primesBacking = [2,3]
    func _extendPrimesBacking()->Int {
    var candidate = _primesBacking.last!
        nextCandidate: while true {
            candidate += 2
            let maxDivisor = Int(sqrt(Double(candidate)))
            for p in _primesBacking {
                if p > maxDivisor {
                    break
                } else if divides(candidate, p) {
                    continue nextCandidate
                }
            }
            _primesBacking.append(candidate)
            return candidate
        }
    }
    let primes = Stream(2, Stream(3, Stream.streamWith({return _extendPrimesBacking()})))
#endif


func triangleNum(i:Int)->Int {
    return i * (i + 1) / 2
}

func isTriangleNum(x:Int)->Bool {
    /*
    we know t(n) = ½n(n+1). Can we compute the inverse?
    2*t(n) = n^2 + n
    2*t(n) + 1/4 = n^2 + n + 1/4
    2*t(n) + 1/4 = (n+1/2)^2
    sqrt(2*t(n) + 1/4) = n+1/2
    sqrt(2*t(n) + 1/4) - 1/2 = n
    
    so, tInverse(x) = sqrt(2*x + 1/4) - 1/2
    */
    let candidateInverse = Int(round(sqrt(2*Double(x) + 0.25) - 0.5))
    return x == candidateInverse * (candidateInverse + 1) / 2
}

func pentagonalNum(n:Int)->Int {
    return n*(3 * n - 1) / 2
}

func isPentagonalNum(x:Int)->Bool {
    // Pn=n(3n−1)/2. What's P inverse?
    // x = Pinv(x)(3*Pinv(x) - 1) / 2
    // 2/3 x = Pinv(x)**2 - 1/3 Pinv(x)
    // 2/3 x + 1/36 = Pinv(x)**2 - 1/3 Pinv(x) + 1/36
    // 2/3 x + 1/36 = (Pinv(x) - 1/6)**2
    // sqrt(2/3 x + 1/36) = Pinv(x) - 1/6
    // Pinv(x) = sqrt(2/3 x + 1/36) + 1/6
    let candidateSequenceIndex = Int(round(sqrt(2*Double(x)/3 + 1.0/36.0) + 1.0/6.0))
    return x == pentagonalNum(candidateSequenceIndex)
}

func hexagonalNum(n:Int)->Int {
    return n*(2*n - 1)
}

func isHexagonalNum(n:Int)->Bool {
    // HInv(n)*(2*HInv(n) - 1) = n
    // HInv(n)**2 - 1/2 HInv(n) = 1/2 n
    // HInv(n)**2 - 1/2 HInv(n) + 1/4 = 1/2 n + 1/4
    // (HInv(n) - 1/4)**2 = 1/2 n + 1/4
    // HInv(n) - 1/4 = sqrt(1/2 n + 1/4)
    // HInv(n) = sqrt(1/2 n + 1/4) + 1/4
    let candidateSequenceIndex = Int(round(sqrt(Double(n)/2 + 0.25) + 0.25))
    return n == hexagonalNum(candidateSequenceIndex)
}

// MARK: -
// MARK: accumulator
// MARK: -

struct Accumulator<S,T> {
    var val : T
    let _merge : (T,S)->T
    
    init(initial:T, merge:(T,S)->T) {
        val = initial
        _merge = merge
    }
    
    mutating func merge(x:S) {
        val = _merge(val, x)
    }
}

// MARK: -
// MARK: Math
// MARK: -

func divides(n:Int, maybeFactor:Int)->Bool {
    return n % maybeFactor == 0
}

func isEven(n:Int)->Bool {
    return divides(n, 2)
}

func isPalindrome<T : Equatable>(arr:[T])->Bool {
    for i in 0...arr.count/2 {
        if arr[i] != arr[arr.count-1-i] {
            return false
        }
    }
    return true
}

var logPrimes = false

// Input: n >= 0, an integer to be tested for primality;
// Input: k, a parameter that determines the accuracy of the test
// Output: composite if n is composite, otherwise probably prime
func isPrimeRabinMiller(n:Int, k:Int) -> Bool {
    if n <= 1 { return false }
    if n == 2 { return true }
    if n == 3 { return true }
    if n % 2 == 0 { return false }
    
    // Input: n > 3, an odd integer to be tested for primality;
    
    // write n − 1 as 2**s·d with d odd by factoring powers of 2 from n − 1
    var s = 0
    var d = n-1
    while d % 2 == 0 {
        s++
        d /= 2
    }
    
    // WitnessLoop: repeat k times:
    WitnessLoop: for _ in 1...k {
        
        // pick a random integer a in the range [2, n − 2]
        let a = arc4random_uniform(n-3)+2
        
        // x ← a**d mod n
        var x = powmod(a, d, n)
        
        switch x {
            
            // if x = 1 or x = n − 1 then do next WitnessLoop
        case 1, n-1: continue WitnessLoop
        default:
            // repeat s − 1 times:
            for _ in 0..<(s-1) {
                // x ← x2 mod n
                x = powmod(x, 2, n)
                switch x {
                    
                    // if x = 1 then return composite
                case 1: return false
                    
                    // if x = n − 1 then do next WitnessLoop
                case n-1: continue WitnessLoop
                default:
                    break
                }
            }
        }
        // return composite
        return false
    }
    if logPrimes {
        n***
    }
    return true
}

func isPrime(n:Int) -> Bool {
    return isPrimeRabinMiller(n, 10)
}


func square(n:Int)->Int {
    return n*n
}

func isSquare(n:Int)->Bool {
    let candidateRoot = Int(round(sqrt(Double(n))))
    return square(candidateRoot) == n
}

func gcd(a:Int, b:Int)->Int {
    switch b {
    case 0: return a
    case _: return gcd(b, a % b)
    }
}

func maxInt(a:Int, b:Int)->Int {
    return max(a,b)
}

func _maxIndex<T1:Comparable>(a:T1, b:T1)->Int {
    if a > b {
        return 0
    } else {
        return 1
    }
}

func _maxIndex<T1:Comparable,T2:Comparable>(a:(T1,T2), b:(T1,T2))->Int {
    let (a1,a2) = a
    let (b1,b2) = b
    if a1 > b1 {
        return 0
    } else if a1 == b1 {
        return _maxIndex(a2,b2)
    } else {
        return 1
    }
}

func _maxIndex<T1:Comparable,T2:Comparable,T3:Comparable>(a:(T1,T2,T3), b:(T1,T2,T3))->Int {
    let (a1,a2,a3) = a
    let (b1,b2,b3) = b
    if a1 > b1 {
        return 0
    } else if a1 == b1 {
        return _maxIndex((a2,a3),(b2,b3))
    } else {
        return 1
    }
}

func max<T1:Comparable,T2:Comparable>(a:(T1,T2), b:(T1,T2))->(T1,T2) {
    return _maxIndex(a,b) == 0 ? a : b
}

func _maxIndex<T1:Comparable,T2:Comparable,T3:Comparable>(a:(T1,T2,T3), b:(T1,T2,T3))->(T1,T2,T3) {
    return _maxIndex(a,b) == 0 ? a : b
}

func mulmod(aIn:Int, bIn:Int, mod:Int) -> Int {
    let (prod, overflow) = Int.multiplyWithOverflow(aIn, bIn)
    if !overflow {
        return prod % mod
    } else {
        var (a,b,mod) = (aIn,bIn,mod)
        var res = 0;
        while (a != 0) {
            if (a % 2 == 1) {
                res = (res + b) % mod
            }
            a /= 2
            b = b*2 % mod;
        }
        return res;
    }
}

func _pow(b:Int, e:Int, coeff:Int)->Int {
    if e == 0 {
        return coeff
    } else if isEven(e) {
        return _pow(b*b,e/2,coeff)
    } else {
        return _pow(b,e-1,coeff*b)
    }
}

func pow(b:Int, e:Int)->Int {
    return _pow(b, e, 1)
}

func _powmod(b:Int, e:Int, mod:Int, coeff:Int)->Int {
    if e == 0 {
        return coeff
    } else if isEven(e) {
        return _powmod(mulmod(b,b,mod),e/2, mod, coeff)
    } else {
        return _powmod(b, e-1, mod, mulmod(coeff,b,mod))
    }
}

func powmod(b:Int, e:Int, mod:Int)->Int {
    return _powmod(b % mod, e, mod, 1)
}

func arc4random_uniform(n:Int) -> Int {
    if n <= Int(UInt32.max) {
        return Int(arc4random_uniform(UInt32(n)))
    } else {
        let hi = n / (2 << 30)
        let lo = n % (2 << 30)
        
        let hiRand = Int(arc4random_uniform(UInt32(hi)))
        let loRand = Int(arc4random_uniform(UInt32(lo)))
        return hiRand*(2 << 30) + loRand
    }
}

typealias SparseArray = [(Int,Int)]

func componentwiseOp(a:SparseArray, b:SparseArray, op:(Int,Int)->Int) -> SparseArray {
    var c = SparseArray()
    var aCursor = 0
    var bCursor = 0
    while (aCursor < a.count && bCursor < b.count) {
        let (aIndex, aVal) = a[aCursor]
        let (bIndex, bVal) = b[bCursor]
        if (aIndex < bIndex) {
            let term = (aIndex, op(aVal, 0))
            c.append(term)
            aCursor++
        } else if (aIndex == bIndex) {
            let term = (aIndex, op(aVal, bVal))
            c.append(term)
            aCursor++
            bCursor++
        } else {
            let term = (bIndex, op(0, bVal))
            c.append(term)
            bCursor++
        }
    }
    while aCursor < a.count {
        let (aIndex, aVal) = a[aCursor++]
        let term = (aIndex, op(aVal, 0))
        c.append(term)
    }
    while bCursor < b.count {
        let (bIndex, bVal) = b[bCursor++]
        let term = (bIndex, op(0, bVal))
        c.append(term)
    }
    return c
}

func +(a:SparseArray, b:SparseArray) -> SparseArray {
    return componentwiseOp(a, b, +)
}

func *(coeff:Int, a:SparseArray) -> SparseArray {
    var res = a
    for i in 0..<res.count {
        let (place, value) = res[i]
        res[i] = (place, coeff*value)
    }
    return res
}

func max(a:SparseArray, b:SparseArray) -> SparseArray {
    return componentwiseOp(a, b, max)
}

typealias Factors = SparseArray // 20 = 2**2 * 5**1 == [(2,2),(5,1)]

func factor(n:Int)->Factors {
    var unfactored = n
    var factors = Factors()
    for p in primes {
        var power = 0
        while divides(unfactored, p) {
            power++
            unfactored /= p
        }
        if power > 0 {
            factors.append((p,power) as (Int,Int))
        }
        
        if unfactored == 1{
            break
        }
    }
    return factors
}

func unfactor(factors:Factors)->Int {
    return factors.map({pow($0, $1)}).reduce(1, combine: *)
}

func *(a:Factors, b:Factors) -> Factors {
    return ((a as SparseArray) + (b as SparseArray)) as Factors
}

func /(a:Factors, b:Factors) -> Factors {
    return (a as SparseArray) + -1 * (b as SparseArray)
}

func factoredFactorial(n:Int)->Factors {
    return Array(1...n).map(factor).reduce(Factors(), combine: *)
}

let factorial : Int->Int = {
    var fac : (Int->Int)!
    func _fac(n:Int)->Int {
        switch n {
        case 0,1: return 1
        case _: return n * fac(n-1)
        }
    }
    fac = denseMemoize(_fac)
    return fac
}()

//func almostFactorial(recur:Int->Int)->(n:Int)->Int

//let factorial = fix(almostFactorial)

//let factorial : (Int->Int) = {
//    var _factorial : (Int->Int)!
//    _factorial = denseMemoize {(n:Int) -> Int in
//        switch n {
//        case 1: return 1
//        case _: return n * _factorial(n-1)
//        }
//    }
//    return _factorial
//}()


func combinations(n:Int, k:Int)->Int {
    let numerFactors = factoredFactorial(n)
    let denomFactors = factoredFactorial(n-k) * factoredFactorial(k)
    let simplifiedFactors = numerFactors / denomFactors
    return unfactor(simplifiedFactors)
}

func divisorsCount(n:Int) -> Int {
    return factor(n).map({$1+1}).reduce(1,*)
}

func allProductsUsingSubsetsOfFactors(factors:Slice<(Int,Int)>)->[Int] {
    // all products will either 
    // (1) use the first factor or
    // (2) not
    // that's how we can recurse.
    if factors.count == 0 {
        return [1]
    } else {
        let productsNotUsingFirstFactor = allProductsUsingSubsetsOfFactors(factors[1..<factors.count])
        let (prime,power) = factors[0]
        let divisorsOfFirstTerm = Array(1...power).map { pow(prime,$0) }
        let productsUsingFirstFactor = lazy(cartesianProduct(divisorsOfFirstTerm, productsNotUsingFirstFactor)).map {$0*$1}
        return productsUsingFirstFactor + productsNotUsingFirstFactor
    }
}

func divisors(n:Int) ->[Int] {
    return allProductsUsingSubsetsOfFactors(Slice<(Int,Int)>(factor(n))).sorted(<)
}

func properDivisors(n:Int) ->[Int] {
    return divisors(n).filter({n != $0})
}

func permutationsGen<T>(inArray : [T]) -> GeneratorOf<[T]> {
    let numEls = inArray.count
    var counters = Array<Int>(count: numEls, repeatedValue: 0)
    counters[0] = -1
    var array = inArray
    return GeneratorOf<[T]> {
        for n in 0..<numEls {
            let c = counters[n]
            let i1 = n % 2 == 0 ? 0 : c
            let i2 = n
            swap(&array[i1], &array[i2])
            
            if c < n {
                counters[n]++
                for i in 0..<n {
                    counters[i] = 0
                }
                return array
            }
        }
        return nil
    }
}


// MARK: -
// MARK: Digits
// MARK: -

func digits(n:Int, # base:Int)->[Int] {
    var digits = [Int]()
    var rest = n
    while rest != 0 {
        digits.append(rest % base)
        rest /= base
    }
    return digits
}

func digits(n:Int)->[Int] {
    return digits(n, base:10)
}

extension Int {
    init<Seq:SequenceType where Seq.Generator.Element == Int>(digits:Seq) {
        var res = 0
        for dig in digits {
            res*=10
            res+=dig
        }
        self.init(res)
    }
}

func digitsToBitfield(digits:[Int])->UInt {
    var bitfield:UInt = 0
    for digit in digits {
        bitfield |= 1 << UInt(digit)
    }
    return bitfield
}

func digits(xs:[Int], timesCoefficient coeff:Int=1, plusDigits ys:[Int] = [Int](), base:Int = 10)->[Int] {
    func digit(zs:[Int], i:Int)->Int {
        return i < zs.count ? zs[i] : 0
    }
    
    let maxLen = max(xs.count,ys.count)
    var sumDigits = [Int]()
    sumDigits.reserveCapacity(maxLen)
    
    var carry = 0
    var i = 0
    while i < maxLen || carry != 0 {
        let sum = coeff*digit(xs,i) + digit(ys,i) + carry
        sumDigits.append(sum % base)
        carry = sum / base
        i++
    }
    return sumDigits
}

