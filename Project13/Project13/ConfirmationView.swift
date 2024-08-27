//
//  ContentView.swift
//  Project13
//
//  Created by Iphigenie Bera on 8/25/24.
//

import SwiftUI

struct ConfirmationView: View {
    @State private var blurAmount = 0.0
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white


    var body: some View {
        Button("Hello, World!") {
            showingConfirmation = true
        }
        .frame(width: 300, height: 300)
        .background(backgroundColor)
        .confirmationDialog("Change background", isPresented: $showingConfirmation){
            Button("Red"){ backgroundColor = .red}
            Button("Green") { backgroundColor = .green }
            Button("Blue") { backgroundColor = .blue }
            Button("Cancel", role: .cancel) { }
        }message:{
            Text("Select a new Color")
        }
//        VStack {
//            Text("Hello, World!")
//                .blur(radius: blurAmount)
//
//            Slider(value: $blurAmount, in: 0...20)
//                // onchange can be attached anywhere!
//                .onChange(of: blurAmount){oldValue, newValue in
//                    print("New Value is \(newValue)")
//                }
//        }
    }
}

#Preview {
    ConfirmationView()
}
