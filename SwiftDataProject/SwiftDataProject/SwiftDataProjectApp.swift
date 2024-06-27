//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Iphigenie Bera on 6/26/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
