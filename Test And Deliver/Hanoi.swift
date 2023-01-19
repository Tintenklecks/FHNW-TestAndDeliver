// Created 18.01.23 

import Foundation

class Hanoi {
    static func move(n: Int, from: String, to: String, using: String) {
        if n == 1 {
            print("Move upmost disk from \(from) to \(to)")
        } else {
            move(n: n-1, from: from, to: using, using: to)
            print("Move disk \(n) from \(from) to \(to)")
            move(n: n-1, from: using, to: to, using: from)
        }
    }
}
