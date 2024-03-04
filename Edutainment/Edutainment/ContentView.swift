//
//  ContentView.swift
//  Edutainment
//
//  Created by Iphigenie Bera on 3/2/24.
//

import SwiftUI

//- The player needs to select which multiplication tables they want to practice. This could be pressing buttons, or it could be an “Up to…” stepper, going from 2 to 12.
//- The player should be able to select how many questions they want to be asked: 5, 10, or 20.
//
//- You should randomly generate as many questions as they asked for, within the difficulty range they asked for.
//
struct ContentView: View {
    @State private var currentTable=2;
    @State private var numberOfQuestions=1;
    @State private var counter=1;
    @State private var diffulty="easy";
    @State private var diffultylevels=["easy","medium","hard"]
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.blue
                Text("Answer")
            }.frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: 150,
                alignment: .topLeading
              )
            Form{
//                Section(header: Text("")){
//                    Text("choose table to practice")
//                        .font(.headline)
//                    ForEach(0..<3){number in
//                        Button{
//                            withAnimation(.spring()){
//                                solutionChecked(number)
//                            }
//                        }label:{
//                            Text("\(currentQuestions[number])")
//                        }
//                        
//                    }
//                }
                
                Section(header: Text("Select multiplication table")){
                    Text("choose table to practice")
                        .font(.headline)
                    Stepper("practicing for \(currentTable.formatted()) table", value:$currentTable, in : 2...12, step:1)
                }
                
                Section(header: Text("SELECT difficulty level")){
                    Text("choose difficulty level")
                        .font(.headline)
                    Picker("questions count: ", selection:$diffulty){
                        ForEach(diffultylevels, id:\.self){
                            num in
                            Text("\(num)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Select number of questions")){
                    Text("Number of Questions")
                        .font(.headline)
                    Picker("questions count: ", selection:$numberOfQuestions){
                        ForEach(Array(stride(from:5, to:20, by:5)), id:\.self){
                            num in
                            Text("\(num) questions")
                        }
                    }
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
