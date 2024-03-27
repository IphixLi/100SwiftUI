//
//  ContentView.swift
//  Habit-tracker
//
//  Created by Iphigenie Bera on 3/19/24.
//

import SwiftUI

struct ActivityItem: Identifiable, Codable{
    var id = UUID()
    var name : String
    var type: String
    var isChecked: Bool
}


// custom modifier
struct CheckModifier:ViewModifier{
    var checked: Bool
    
    func body(content:Content)->some View{
        content
            .foregroundColor(checked ? Color.green : Color.clear)
            .overlay(Circle().stroke(Color.green, lineWidth: 1))
    }
}

//extension
extension View{
    func CheckFill(checkState: Bool)->some View {
        modifier(CheckModifier(checked: checkState))
    }
}
                 
                 
                 

@Observable
class Activities{
    var items = [ActivityItem](){
        didSet{
            if let encoded = try?JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey:"Items")
            }
        }
    }
    
    init(){
        if let saveditems=UserDefaults.standard.data(forKey:"Items"){
            if let decodeditems = try? JSONDecoder().decode([ActivityItem].self, from:saveditems){
                items=decodeditems
                return
            }
        }
    }
}


struct ContentView: View {
    @State private var activities = Activities()
    var body: some View {
        NavigationStack{
            List{
                ForEach(activities.items){ activity in
                    
                    HStack{
                        Button{
                            CheckActivity(withId: activity.id)
                        }label:{
                            Circle()
                                .frame(width: 20, height: 20)
                                .CheckFill(checkState: activity.isChecked)
                        }
                        
                        VStack(alignment: .leading){
                            Text(activity.name)
                                .font(.headline)
                            Text(activity.type)
                        }
                    }
                }
                .onDelete(perform: removeActivity)
            }
            .navigationTitle("Habit-Tracker")
            .toolbar{
                NavigationLink(destination: AddView(activities: activities)){
                    Image(systemName: "plus")
                }
            }
            
            
            
            
            
        }
    }
    
    func removeActivity(at offsets: IndexSet){
        activities.items.remove(atOffsets: offsets)
        
    }
    
    func CheckActivity(withId id: UUID) {
        if let index = activities.items.firstIndex(where: { $0.id == id }) {
            activities.items[index].isChecked.toggle()
        }
    }
    

}

#Preview {
    ContentView()
}
