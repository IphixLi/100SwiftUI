//
//  ContentView.swift
//  Navigation
//
//  Created by Iphigenie Bera on 3/16/24.
//

import SwiftUI




struct ContentView: View {
    @State private var title = "SwiftUI"
    
    
    var body: some View {
        NavigationStack {
            Text("Hello, world!")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}


//struct ContentView: View {
//    var body: some View {
//        NavigationStack{
//            Text("Hello World")
//                .toolbar{
//                    ToolbarItemGroup(placement: .navigation){
//                        
//                        // it is better to use sematic option for placement
//                        // -- .destructiveAction, .cancellationAction, .confirmationAction
//                        Button("Tap Me"){
//                            //button action
//                        }
//                        
//                        Button("Hehehe"){
//                            //another button
//                        }
//                    }
//                }
//        }
////        NavigationStack {
////            List(0..<100) { i in
////                Text("Row \(i)")
////            }
////            .navigationTitle("Title goes here")
////            .navigationBarTitleDisplayMode(.inline)
////            .toolbarBackground(.blue)
////            .toolbarColorScheme(.dark)
////            //.toolbar(.hidden, for: .navigationBar) hide navigation bar
////        }
//    }
//}

















struct DetailView: View{
    var number: Int
    
    var body: some View {
        NavigationLink("Go to Random Number", value:Int.random(in:1...100))
            .navigationTitle("Number: \(number)")
    }
}

struct Student: Hashable{
    var id = UUID()
    var name: String
    var age: Int
}

@Observable
class PathStore{
    var path: NavigationPath{
        didSet{
            save()
        }
    }
    
    private let savePath=URL.documentsDirectory.appending(path: "SavedPath")
    
    init(){
        if let data = try? Data(contentsOf:savePath){
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from:data){
                path = NavigationPath(decoded)
                return
            }
        }
        path = NavigationPath()
    }
    
    func save(){
        guard let representation = path.codable else{return }
        do{
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch{
            print("Failed to save navigation data")
        }
    }
}


//struct ContentView: View {
//    @State private var pathStore = PathStore()
//    var body: some View {
//        NavigationStack( path: $pathStore.path){
//            DetailView(number:0)
//                .navigationDestination(for: Int.self){i in
//                    DetailView(number: i)
//                }
//            
//        }
//    }
//}

    
#Preview{
        ContentView()
}



struct PathView: View {
    @State private var path=[Int]()
    var body: some View {
        NavigationStack(path: $path){
//            List(0..<100){ i in
//                NavigationLink("Select \(i)", value: i)
//            }
            VStack{
                Button("Show 32") {
                    path = [32]
                }

                Button("Show 64") {
                    path.append(64)
                }
                Button("Show 32 then 64") {
                    path = [32, 64]
                }
            }
            .navigationDestination(for: Int.self){selection in
                Text("You selected \(selection)")
            }
        }
    }
}

