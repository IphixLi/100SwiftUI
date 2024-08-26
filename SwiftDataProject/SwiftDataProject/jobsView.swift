//
//  jobsView.swift
//  SwiftDataProject
//
//  Created by Iphigenie Bera on 6/28/24.
//

import SwiftUI

struct jobsView: View {
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        Button("Add Samples", systemImage: "plus") {
            addSample()
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
    jobsView()
}
