// Created 16.01.23

import SwiftUI

struct ContentView: View {
    @State private var tab: Int = 0
    var body: some View {
        TabView(selection: $tab) {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .tabItem {
                Image(systemName: "flag.checkered.2.crossed")
            }
            .tag(0)

            Text("Hey, I am number 2")
                .tabItem {
                    Image(systemName: "cablecar.fill")
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
