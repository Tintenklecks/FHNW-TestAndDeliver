//
//  ViewModel.swift
//  OpenAI
//
//  Created by Ingo Boehme on 14.12.22.
//

import Foundation

// MARK: - Message

struct Message: Identifiable {
    let id = UUID()
    let timestamp = Date()
    let isAI: Bool
    let text: String
}

extension ChatBotView {
    class ViewModel: ObservableObject {
        @Published var messages: [Message] = []
        @Published var aiModel = ""
        @Published var errorMessage = ""

        var model = Model()

        func sendMessage(text: String) {
            messages.append(Message(isAI: false, text: text))
            Task {
                do {
                    let message = try await model.getAnswer(question: text, aiModel: aiModel)
                    DispatchQueue.main.async {
                        self.messages.append(Message(isAI: true, text: message.trimmingCharacters(in: .whitespacesAndNewlines)))
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
}
