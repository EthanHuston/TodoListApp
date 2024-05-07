//
//  ContentView.swift
//  TodoListApp
//
//  Created by Ethan Huston on 5/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks: [Task] = []
    
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
                VStack {
                    ForEach(tasks) { task in
                        TaskView(task: task).padding(.top, 5)
                    }
                }
            }
            
        }
        .padding().onAppear(perform: {
            Services.shared.fetchTasks { (result) in
                self.tasks = result ?? []
            }
        })
    }
}

#Preview {
    ContentView()
}
