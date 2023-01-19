//
//  Network.Error.swift
//  OpenAIImages
//
//  Created by Ingo Boehme on 21.12.22.
//

import Foundation

// MARK: - NetworkError

enum NetworkError: Error {
    case decoding
    case internet
    case noData
    case httpError(Int)
    case misc(String)
    public var localizedDescription: String {
        return "dsfgdfgdfgf"
    }

    var errDescription: String {
        switch self {
        case .decoding: return "Decoding error"
        case .internet: return "Internet connection error"
        case .noData: return "delivered data is empty"
        case .httpError(let status): return "HTTP Error Code \(status)"
        case .misc(let text): return "MISC ERROR: \(text)"
        }
    }
}
