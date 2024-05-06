//
//  ContentView.swift
//  TodoListApp
//
//  Created by Ethan Huston on 5/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks: [Task] = [Task(id: "1234", taskDescription: "Grocery Shopping", createdDate: "February 28 2023", dueDate: "March 8 2023", completed: false), Task(id: "12345", taskDescription: "Walk Dog", createdDate: "February 28 2023", dueDate: "March 8 2023", completed: false)]
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    print("Accessing Settings")
                }, label: {
                    Image(systemName: "gearshape.fill").foregroundStyle(.black).font(.system(size: 25))
                })
                Spacer()
                Text("Task List").font(.system(size: 25))
                Spacer()
                Button(action: {
                    print("Adding Task")
                }, label: {
                    Image(systemName: "plus.circle.fill").foregroundStyle(.black).font(.system(size: 25))
                })
            }
            ScrollView {
                List(tasks, id: \.id) { task in
                    TaskView(task: task)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
