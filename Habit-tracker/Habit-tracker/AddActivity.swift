//
//  AddActivity.swift
//  Habit-tracker
//
//  Created by Iphigenie Bera on 3/19/24.
//


import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var type = "Personal"
    @State private var isChecked = false

    var activities: Activities

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ActivityItem(name: name, type: type, isChecked: isChecked)
                    activities.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(activities: Activities())
}
