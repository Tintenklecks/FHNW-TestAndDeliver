// Created 18.01.23 

import Foundation

extension Int {
    static func factorial(n: Int) -> Int {
        if n == 0 {
            return 1
        }
        return n * factorial(n: n - 1)
    }
    
    
}
