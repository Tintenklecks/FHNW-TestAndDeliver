//
//  OpenAI.Request.Structures.swift
//  AI Chat
//
//  Created by Ingo Boehme on 24.12.22.
//

import Foundation



// MARK: - ChatBotRequest

struct ChatBotRequest: Codable {
    let model: String
    let prompt: String
    var max_tokens = 2048
    var temperature = 1.0
}

// MARK: - ModerationBody

struct ModerationBody: Codable {
    let input: String
}

// MARK: - ImageBody

struct ImageBody: Codable {
    let prompt: String
    let n: Int
    let size: String
}

