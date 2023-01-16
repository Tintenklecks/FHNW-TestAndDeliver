//
//  OpenAI structures.swift
//  OpenAIImages
//
//  Created by Ingo Boehme on 21.12.22.
//

import Foundation

// MARK: - AIImages

struct AIImages: Codable {
    let created: Int
    let data: [Datum]
}

// MARK: - Datum

struct Datum: Codable {
    let url: String
}

// MARK: - Moderation

struct Moderation: Codable {
    let results: [ModerationResult]
}

// MARK: - ModerationResult

struct ModerationResult: Codable {
    let categories: ModerationCategories
}

// MARK: - ModerationCategories

struct ModerationCategories: Codable {
    let hate: Bool
    let hateThreatening: Bool
    let selfHarm: Bool
    let sexual: Bool
    let sexualMinors: Bool
    let violence: Bool
    let violenceGraphic: Bool
    
    var isBlocked: Bool {
        hate || hateThreatening ||  selfHarm || sexual || sexualMinors || violence || violenceGraphic
    }

    enum CodingKeys: String, CodingKey {
        case hate
        case hateThreatening = "hate/threatening"
        case selfHarm = "self-harm"
        case sexual
        case sexualMinors = "sexual/minors"
        case violence
        case violenceGraphic = "violence/graphic"
    }
}

// MARK: - ChatbotResult
struct ChatbotResult: Codable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
    
    var answerList: [String] {
        choices.map { $0.text }
    }
    
    var answer: String {
        String(answerList.joined(separator: "\n"))
    }
    
}

// MARK: - Choice
struct Choice: Codable {
    let text: String
}


// MARK: - Models
struct AIModels: Codable {
    let data: [ModelName]
    
    var modelNames: [String] {
        data.map { $0.id }
    }
}

// MARK: - Datum
struct ModelName: Codable {
    let id: String
}
