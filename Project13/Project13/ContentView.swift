//
//  ContentView.swift
//  Project13
//
//  Created by Iphigenie Bera on 8/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        ContentUnavailableView("No snippets", systemImage: "swift", description: Text("You don't have any saved snippets yet."))
        
        ContentUnavailableView {
            Label("No snippets", systemImage: "swift")
        } description: {
            Text("You don't have any saved snippets yet.")
        } actions: {
            Button("Create Snippet") {
                // create a snippet
            }
            .buttonStyle(.borderedProminent)
        }

    }
}

#Preview {
    ContentView()
}
