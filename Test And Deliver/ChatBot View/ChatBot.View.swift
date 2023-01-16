//
//  ChatBotView.swift
//  OpenAI
//
//  Created by Ingo Boehme on 14.12.22.
//

import SwiftUI

// MARK: - ChatBotView

struct ChatBotView: View {
    @EnvironmentObject var appState: AppState

    @StateObject var viewModel = ViewModel()
    @State private var text: String = ""

    var body: some View {
        VStack {
            if !viewModel.messages.isEmpty {
                MessagesScrollView(viewModel: viewModel)
            } else {
                Text("Just type your question in the message field and press the send button")
                    .frame(maxWidth: 320)
                    .foregroundColor(.secondary)
                    .padding(64)
            }

            Spacer()
            Divider()

            QuestionTextView(text: $text, viewModel: viewModel)
        }
        .onAppear {
            viewModel.aiModel = appState.aiModel
        }
    }
}

// MARK: - MessagesScrollView

struct MessagesScrollView: View {
    @ObservedObject var viewModel: ChatBotView.ViewModel

    var body: some View {
        ScrollViewReader { value in
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.messages.indices, id: \.self) { index in
                        ChatBubbleView(message: viewModel.messages[index])
                            .tag(index)
                            .onTapGesture(count: 2) {
                                print("Double")
                            }
                            .onTapGesture {
                                print("single")
                            }
                            .contextMenu {
                                Button(action: {
                                    UIPasteboard.general.string = self.viewModel.messages[index].text
                                }) {
                                    Text("Copy to clipboard")
                                    Image(systemName: "doc.on.doc")
                                }
                            }
                    }
                }
            }
            .onAppear {
                value.scrollTo(viewModel.messages.count-1, anchor: .bottom)
            }
            .onChange(of: viewModel.messages.count) { _ in
                value.scrollTo(viewModel.messages.count-1, anchor: .bottom)
            }
        }
    }
}

// MARK: - QuestionTextView

struct QuestionTextView: View {
    @Binding var text: String
    @ObservedObject var viewModel: ChatBotView.ViewModel
    @FocusState private var focusedField: String?

    var body: some View {
        HStack {
            #if os(macOS)
                TextEditor(text: $text)
                    .padding(8)
                    .frame(height: 48)
                    .buttonStyle(.borderedProminent)
                    .onSubmit {
                        viewModel.sendMessage(text: text)
                        text = ""
                    }

            #else
                TextField("enter message", text: $text, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .focused($focusedField, equals: "text")
                    .lineLimit(5)
//                    .contextMenu {
//                        Button(action: {
//                            UIPasteboard.general.string = self.text
//                        }) {
//                            Text("Copy to clipboard")
//                            Image(systemName: "doc.on.doc")
//                        }
//                    }
                    .onSubmit {
                        viewModel.sendMessage(text: text)
                        text = ""
                    }
            #endif

            Button {
                if text != "" {
                    viewModel.sendMessage(text: text)
                    text = ""
                }
            } label: {
                Image(systemName: "paperplane.fill")
            }
        }
        .padding()
        .onAppear {
            focusedField = "text"
        }
    }
}

// MARK: - ChatBubbleView

struct ChatBubbleView: View {
    let message: Message

    var body: some View {
        HStack {
            if !message.isAI {
                Spacer()
            }
            Text(message.text)
                .padding(.horizontal)
                .padding(.vertical, 6)
                .background(
                    Color(message.isAI ? "ChatAI" : "ChatHuman")
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .clipped()
                )
                .padding(6)
                .padding(.leading, message.isAI ? 10 : 56)
                .padding(.trailing, message.isAI ? 56 : 10)
            if message.isAI {
                Spacer()
            }
        }
    }
}

// MARK: - ChatBubble_Previews

struct ChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ChatBubbleView(
                message:
                Message(isAI: false, text: "Hallo Bot")
            )
            ChatBubbleView(
                message:
                Message(isAI: true, text: "Hallo Mensch")
            )
            ChatBubbleView(
                message:
                Message(isAI: false, text: "Sagt ich zum Augenblick: `Verweile doch, Du bist so schön`, dann magst Du mich in Ketten schlagen, dann möge ich zugrunde geh'n.")
            )
        }
    }
}

// MARK: - ChatBotView_Previews

struct ChatBotView_Previews: PreviewProvider {
    static var viewModel = ChatBotView.ViewModel()
    static var previews: some View {
        ChatBotView()
            .onAppear {
                viewModel.messages.append(Message(isAI: false, text: "Hallo Bot"))
                viewModel.messages.append(Message(isAI: true, text: "Hallo Mensch"))
            }
    }
}
