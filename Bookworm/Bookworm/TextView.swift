//
//  TextView.swift
//  Bookworm
//
//  Created by Iphigenie Bera on 5/8/24.
//

import SwiftUI

struct TextView: View {
    @AppStorage("notes") private var notes = ""
    var body: some View {
        NavigationStack {
            TextField("Enter your text", text:$notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .navigationTitle("Notes")
                .padding()
            
//            TextEditor(text: $notes)
//                .navigationTitle("Notes")
//                .padding()
        }
    }
}

#Preview {
    TextView()
}
