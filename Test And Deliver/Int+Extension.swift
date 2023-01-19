// Created 18.01.23

import Foundation

extension Int {
    static func factorialRecursive(n: Int) -> Int {
        if n == 1 {
            return 1
        }
        return n * factorialRecursive(n: n - 1)
    }

    static func factorial(n: Int) -> Int {
        var result = 1
        for i in 1...n {
            result *= i
        }
        return result
    }

    static func fib(_ n: Int) -> Int {
        if n <= 2 {
            return 1
        } else {
            return fib(n - 1) + fib(n - 2)
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    static func fibonacci(n: Int) -> Int {
        var first = 0
        var second = 1
        var current = 0
        if n == 0 {
            return 0
        } else if n == 1 {
            return 1
        } else {
            for _ in 2...n {
                current = first + second
                first = second
                second = current
            }
            return current
        }
    }
}
