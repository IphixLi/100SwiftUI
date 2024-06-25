//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Iphigenie Bera on 4/4/24.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
