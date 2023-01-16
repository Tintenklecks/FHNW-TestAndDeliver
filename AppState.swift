//
//  AppState.swift
//  OpenAI
//
//  Created by Ingo Boehme on 13.12.22.
//

import Foundation
import Network
import SwiftUI

// MARK: - AppTabs

enum AppTab: Int {
    case image = 0
    case chat = 1
    case settings = 2

    var title: String {
        switch self {
            case .image: return "AI Image"
            case .chat: return "Chat Bot"
            case .settings: return "Settings"
        }
    }
}

// MARK: - AppState

class AppState: ObservableObject {
    @Published var isOffline: Bool = true
    @AppStorage("tab") var selectedTab: AppTab = .chat
    
    @AppStorage("aimodel") var aiModel = "text-davinci-003"
    
    

    init() {
        setupInternetMonitoring()
    }

    // MARK: - Checking Internet Connectivity -

    private var monitor = NWPathMonitor()

    func setupInternetMonitoring() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                // FIXME: Fix and simplify this one here
                if path.status == .satisfied {
                    self.isOffline = false
                } else {
                    self.isOffline = true
                }
            }
        }

        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }

    public func stopInternetMonitoring() {
        monitor.cancel()
    }
}
