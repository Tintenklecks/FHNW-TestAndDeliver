// Created 16.01.23 

import Foundation

extension String {
    var firstCapital: String {
        self.prefix(1).uppercased() + self.suffix(self.count - 1).lowercased()
    }
    
    var unifiedName: String {
        return ""
    }

    
}
