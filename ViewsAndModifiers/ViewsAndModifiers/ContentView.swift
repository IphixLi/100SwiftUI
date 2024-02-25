//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Iphigenie Bera on 2/21/24.
//

import SwiftUI

// custom modifier
struct Title:ViewModifier{
    func body(content:Content)->some View{
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
        
    }
}

//extension
extension View{
    func titleStyle()->some View {
        modifier(Title())
    }
}


struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct ContentView: View {
    struct CapsuleText: View {
        var text: String

        var body: some View {
            Text(text)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(.capsule)
        }
    }
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello World")
                //.modifier(Title())
                .titleStyle()
            
            CapsuleText(text: "First")
                .foregroundStyle(.white)
            CapsuleText(text: "Second")
                .foregroundStyle(.yellow)
        }
        .watermarked(with: "Hack with Swift")
        }
}

#Preview {
    ContentView()
}
