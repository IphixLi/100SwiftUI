//
//  ContentView.swift
//  Moonshot
//
//  Created by Iphigenie Bera on 3/6/24.
//

import SwiftUI

struct CustomText: View {
    let text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}


struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

//let layout = [
//    GridItem(.fixed(80)),
//    GridItem(.fixed(80)),
//    GridItem(.fixed(80))
//]

//let layout = [
//    GridItem(.adaptive(minimum: 80)),
//]

let layout = [
    GridItem(.adaptive(minimum: 80, maximum: 120)),
]


struct part1: View {
    var body: some View {
        
//        ScrollView(.horizontal) {
//            LazyHGrid(rows: layout) {
//                ForEach(0..<1000) {
//                    Text("Item \($0)")
//                }
//            }
//        }
//
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
        
        Button("Decode JSON") {
            let input = """
            {
                "name": "Taylor Swift",
                "address": {
                    "street": "555, Taylor Swift Avenue",
                    "city": "Nashville"
                }
            }
            """

            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address.street)
            }
            
        }
        
        NavigationStack{
            List(0..<100) { row in
                NavigationLink("Row \(row)") {
                    Text("Detail \(row)")
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}






struct Scrollview: View {
    var body: some View {
        VStack {
            Image("Screenshot 2024-02-26 at 9.19.04 PM")
                .resizable()
                //.scaledToFit()
                .scaledToFill()
                .containerRelativeFrame(.horizontal){
                    size, axis in size*0.8
                }
                //.frame(width: 300, height:300)
                //.clipped()
            
            
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(0..<100) {
                        CustomText("Item \($0)")
                            .font(.title)
                    }
                }.frame(maxWidth: .infinity)
            }

        }
        .padding()
    }
}

#Preview {
    part1()
}
