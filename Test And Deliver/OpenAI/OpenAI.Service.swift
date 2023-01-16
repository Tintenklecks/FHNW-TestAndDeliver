//
//  OpenAIService.swift
//  OpenAIImages
//
//  Created by Ingo Boehme on 15.12.22.
//

import Foundation

// MARK: - OpenAIService

class OpenAIService {
    static func generateImage(prompt: String, size: String) async throws -> AIImages {
        let request = OpenAIEndpoints.generateImage(prompt, size).request
        let result = try await NetworkService.load(from: request, convertTo: AIImages.self)
        return result
    }

    static func getModeration(prompt: String) async throws -> Moderation {
        let request = OpenAIEndpoints.moderation(prompt).request
        let result = try await NetworkService.load(from: request, convertTo: Moderation.self)
        return result
    }

    static func getModels()  async throws -> AIModels {
        let request = OpenAIEndpoints.models.request
        let result = try await NetworkService.load(from: request, convertTo: AIModels.self)
        return result
    }

    static func getAnswer(question: String, model: String) async throws -> ChatbotResult {
        let request = OpenAIEndpoints.sendChat(question, model).request
        let result = try await NetworkService.load(from: request, convertTo: ChatbotResult.self)
        return result
    }
}
