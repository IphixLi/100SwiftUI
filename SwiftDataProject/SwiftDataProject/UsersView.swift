//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Iphigenie Bera on 6/27/24.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Query var users: [User]
    
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]){
        
        //underscore allow swift access to query
        _users=Query(filter: #Predicate<User>{user in
            user.joinDate>=minimumJoinDate
        }, sort: sortOrder)
    }
    
    var body: some View {
        List(users){user in
            Text(user.name)
            HStack{
                Text(user.name)
                
                Spacer()
                
                Text(String(user.jobs.count))
                    .fontWeight(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
                
            }
        }
    }
}

#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for:User.self)
}
