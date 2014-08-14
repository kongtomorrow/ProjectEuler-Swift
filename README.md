ProjectEuler-Swift
==================

These are solutions in Swift to exercises from [Project Euler](https://projecteuler.net).

I'm pretty much trying out (1) Swift, (2) some [SICP-style streams](http://sarabander.github.io/sicp/html/3_002e5.xhtml#g_t3_002e5) and such. 

Running Problems
----------------

If you just compile and run, it'll run all the problems. Seems reasonable, eh?

That won't be what you want if you're interested in messing with one problem in particular.

To change what's executed, take a look at ```main.swift```.

```swift
probs.methodsStartingWithPrefix("p").map({probs.benchmarkProblem($0)})
probs.methodsStartingWithPrefix("run").map({probs.benchmarkProblem($0)})
//probs.benchmarkProblem(probs.methodsStartingWithPrefix("p").last!) // just the last problem
```

That says "run all methods on ```probs``` that start with ```p``` or ```run```". If you comment out the first line and change the name of the method you're interested in to start with "run", that's an easy way to limit what's executed.

Each problem is in its own file, and you can also remove files from the target to reduce compile time.

Enjoy!