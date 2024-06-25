//
//  ContentView.swift
//  Bookworm
//
//  Created by Iphigenie Bera on 4/4/24.
//
import SwiftUI

//@Bindable used for accessing shared class using @Observable macro
//Binding for simple value piece of data

struct BindingView: View {
    @State private var rememberMe = false
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        VStack{
            PushButton(
                title:"Remember Me",
                isOn:$rememberMe)
            Text(rememberMe ? "On":"Off")
        }
        
    }
}

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool

    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]

    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(colors: isOn ? onColors : offColors, startPoint:.top, endPoint:.bottom))
        
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .shadow(radius: isOn ? 0 : 5)
    }
}



#Preview {
    BindingView()
}
