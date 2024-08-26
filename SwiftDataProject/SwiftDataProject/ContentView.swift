//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Iphigenie Bera on 6/26/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
//    @Query(filter: #Predicate<User>{user in
//        if user.name.localizedStandardContains("R"){
//            if user.city=="London"{
//                return true
//            }else{
//                return false
//            }
//        }else{
//            return false
//        }
//    }, sort: \User.name)  var users: [User]
    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate),
    ]
    
    
    
    @State private var path = [User]()

    var body: some View {
        NavigationStack(path: $path) {
            
            UsersView(minimumJoinDate: showingUpcomingOnly ? .now : .distantPast, sortOrder:sortOrder)
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                EditUserView(user: user)
            }
            .toolbar{
                Button("Add Samples"){
                    try? modelContext.delete(model: User.self)
                    
                    let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))
                    
                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)

                }
            }
            .toolbar {
                Button("Add User", systemImage: "plus") {
                    let user = User(name: "", city: "", joinDate: .now)
                    modelContext.insert(user)
                    path = [user]
                }
                
                Button("Add Sample jobs") {
                    addSample()
                }
                
                Button(showingUpcomingOnly ? "Show Everyone" : "Show Upcoming"){
                    showingUpcomingOnly.toggle()
                }
                Menu("Sort", systemImage: "arrow.up.arrow.down"){
                    Picker("Sort", selection: $sortOrder){
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate),
                            ])
                        
                        Text("Sort by Join Date")
                            .tag([
                                SortDescriptor(\User.joinDate),
                                SortDescriptor(\User.name),
                            ])
                        
                    }
                }
            }
        }

    }
    
    func addSample() {
        let user1 = User(name: "Piper Chapman", city: "New York", joinDate: .now)
        let job1 = Job(name: "Organize sock drawer", priority: 3)
        let job2 = Job(name: "Make plans with Alex", priority: 4)

        modelContext.insert(user1)

        user1.jobs.append(job1)
        user1.jobs.append(job2)
    }
    
}

#Preview {
    ContentView()
}
