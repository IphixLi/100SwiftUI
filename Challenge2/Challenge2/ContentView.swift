//
//  ContentView.swift
//  Challenge2
//
//  Created by Iphigenie Bera on 2/23/24.
//

import SwiftUI


struct TileView: ViewModifier {
    func body(content: Content)-> some View {
        content
            .frame(maxWidth: 70)
            .padding()
            .background(.blue)
            .shadow(radius: 5)
    }
}


struct ContentView: View {
    
    @State private var options = ["rock","paper","scissors"]
    
    @State private var selectOption=Int.random(in:0...2)
    @State private var mode=""
    @State private var choseMode=true
    @State private var playerOption = 0
    
    var modeTitle="Chose mode"
    
    
    
    var body: some View {
        VStack{
            HStack{
                Text("Computer play: ")
                Text(options[selectOption])
                    .modifier(TileView())
            }
            Picker("Choose", selection: $playerOption) {
                ForEach(0..<3) { number in
                    Text(options[number]).tag(number)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: playerOption) { newValue, _ in
                determineWinner(playerChoice: newValue)
            }
            
        }.alert(modeTitle, isPresented: $choseMode){
            Button("win"){restartgame(with: "win")
            }
            Button("lose"){restartgame(with:"lose")
            }
        }
    
    func restartgame(with option: String){
        selectOption=Int.random(in:0...2)
        mode=option
        choseMode.toggle()
    
    }
    }
    func determineWinner(playerChoice: Int) -> String {
            let outcomes: [String] = ["tie", "win", "lose"]
            let resultIndex = (playerChoice - selectOption + 3) % 3
            return outcomes[resultIndex]
        }
}
#Preview {
    ContentView()
}
