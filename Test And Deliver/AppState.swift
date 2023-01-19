//
//  AppState.swift
//  OpenAI
//
//  Created by Ingo Boehme on 13.12.22.
//

import SwiftUI


// MARK: - AppState

class AppState: ObservableObject {
    
    @AppStorage("aimodel") var aiModel = "text-davinci-003"


}
