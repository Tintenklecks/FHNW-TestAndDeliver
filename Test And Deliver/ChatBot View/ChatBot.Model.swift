//
//  Model.swift
//  OpenAI
//
//  Created by Ingo Boehme on 14.12.22.
//

import Foundation

extension ChatBotView {
    class Model {
        func getAnswer(question: String, aiModel: String) async throws -> String {
            let result = try await OpenAIService.getAnswer(question: question, model: aiModel)
            return result.answer
        }
    }
}
