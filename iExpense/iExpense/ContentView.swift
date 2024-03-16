//
//  ContentView.swift
//  iExpense
//
//  Created by Iphigenie Bera on 3/3/24.
//

import SwiftUI
import Observation

//@Observable
//class User{
//    var firstName="Bilbo"
//    var lastName="Baggins"
//    
//}

struct SecondView: View{
    @Environment(\.dismiss) var dismiss
    let name:String
    
    var body: some View{
        Text("Hello, \(name)!")

        Button("Dismiss"){
            dismiss()
        }.padding(20)

    }
}

struct User: Codable {
    let firstName:String
    let lastName:String
}


struct ExpenseItem : Identifiable, Codable{
    var id=UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses : ObservableObject {
    var personalItems : [ExpenseItem] {
        get { items.filter { $0.type == "Personal" } }
        set { }
    }
    
    var businessItems: [ExpenseItem] {
        get { items.filter { $0.type == "Business" } }
    }
    
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items=[]
    }
}



struct ContentView: View{
    @State private var showingAddExpense=false;
    @State private var expenses = Expenses()

    var body: some View{
        NavigationStack {
            List {
                Section{
                    ForEach(expenses.personalItems ) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.identifier))
                                .foregroundStyle(item.amount<10 ? .red :  item.amount<100 ? .blue : .green)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                Section{
                    ForEach(expenses.businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.identifier))
                                .foregroundStyle(item.amount<10 ? .red :  item.amount<100 ? .blue : .green)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button("Add Expense", systemImage: "plus"){
                    showingAddExpense.toggle()
                }
            }
            .sheet(isPresented: $showingAddExpense){
                AddView(expenses: expenses)
            }

        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

}








struct jsonView: View {
    // @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @AppStorage("tapCount") private var tapCount = 0
    @State private var user = User(firstName: "Taylor", lastName: "Swift")
    
    /* access to UserDefaults is through @AppStorage */
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            //UserDefaults.standard.set(tapCount, forKey:"Tap")
        }
        
        Button("Save User") {
            let encoder = JSONEncoder()

            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
    
}


struct DeleteElements: View{
    @State private var showingSheet=false;
    @State private var numbers=[Int]()
    @State private var currentNumber = 1
    
    var body: some View{
        NavigationStack{
            VStack{
                List{
                    ForEach(numbers, id:\.self){
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add number"){
                    numbers.append(currentNumber)
                    currentNumber+=1
                }
            }
            .toolbar{
                EditButton()
            }
        }
             
        Button("Show Second Sheet"){
            showingSheet.toggle()
        }
        .sheet(isPresented:$showingSheet){
            //contents of the sheet
            SecondView(name: "Bera")
        }
    }
    
    
    func removeRows(at offsets: IndexSet){
        numbers.remove(atOffsets: offsets)
    }
}


#Preview {
    ContentView()
}
