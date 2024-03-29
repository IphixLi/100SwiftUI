//
//  ContentView.swift
//  Animations
//
//  Created by Iphigenie Bera on 2/28/24.
//

import SwiftUI



struct CornerRotateModifier: ViewModifier{
    let amount:Double
    let anchor: UnitPoint
    
    func body(content: Content)->some View{
        content
            .rotationEffect(.degrees(amount), anchor:anchor)
            .clipped()
    }
}


extension AnyTransition{
    static var pivot: AnyTransition{
        .modifier(
            active: CornerRotateModifier(amount:-90, anchor:.topLeading),
            identity: CornerRotateModifier(amount:0, anchor:.topLeading)
        )
                  
    }
}

struct ContentView: View{
    @State private var isShowingRed=false
    
    var body: some View{
        ZStack{
            Rectangle()
                .fill(.blue)
                .frame(width:200, height:200)
            
            if isShowingRed{
                Rectangle()
                    .fill(.red)
                    .frame(width:200, height:200)
                    .transition(.pivot)
            }
        }.onTapGesture {
            withAnimation{
                isShowingRed.toggle()
            }
        }
    }
}



struct part4: View {
    @State private var isShowingRed=false
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation{isShowingRed.toggle()}
            }
            if isShowingRed{
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}


struct part3: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(num) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
    }
}


struct CardDrag:View{  //part2
    @State private var dragAmount=CGSize.zero
    
    var body: some View{
        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                   .frame(width: 300, height: 200)
                   .clipShape(.rect(cornerRadius: 10)
                    )
                   .offset(dragAmount)
                   .gesture(DragGesture()
                    .onChanged{dragAmount=$0.translation}
                    .onEnded{_ in withAnimation(.bouncy)
                        {dragAmount = .zero}})
                   
        
    }
}







struct Part2: View {
    @State private var animationAmount=0.0
    @State private var enabled=false
    
    var body: some View {
        
        
        Button("Tap me"){
            enabled.toggle()
            withAnimation(.spring(duration:1, bounce:0.5)){
                animationAmount+=360
            }
            //            withAnimation{
            //                animationAmount+=360
            //            }
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .blue : .red)
        .animation(nil, value: enabled)  // do not animate things above it.
        .foregroundStyle(.white)
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
        .animation(.default, value:enabled)
    }
}

#Preview {
    ContentView()
}



struct part1: View {
    @State private var animationAmount=0.0
    
    var body: some View {
        print(animationAmount)
        
        // return because we have some non-view elements
        return VStack{
            Stepper("Scale amount", value:$animationAmount.animation(
                .easeInOut(duration:1)
                .repeatCount(7,autoreverses: true)), in:1...10)
            
            Spacer()
            Button("Tap me"){
                animationAmount+=1
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmount)
            
            VStack {
                Button("Tap me"){
                    //animationAmount+=1
                }
                .padding(50)
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(.circle)
                //.animation(.spring(duration:1, bounce:0.9), value:animationAmount)
                //.animation(.linear, value: animationAmount)
                //.animation(.default, value:animationAmount)
                //.blur(radius:(animationAmount-1)*3)
                //.scaleEffect(animationAmount)
                
                //---- create ring animation effect
                .overlay(
                    Circle()
                        .stroke(.red)
                        .scaleEffect(animationAmount)
                        .opacity(2-animationAmount)
                        .animation(
                            .easeInOut(duration: 2)
                            .delay(1)
                            //.repeatCount(3, autoreverses: true),
                                .repeatForever(autoreverses: false),
                            value:animationAmount)
                )
                .onAppear{
                    animationAmount=2
                }
            }
            .padding()
        }
    }
}
