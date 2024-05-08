//
//  ContentView.swift
//  TodoListApp
//
//  Created by Ethan Huston on 5/6/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tasks: [Task] = []
    @State private var shouldShowSettings = false
    @State private var shouldShowCreate = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    shouldShowSettings.toggle()
                }, label: {
                    Image(systemName: "gearshape.fill").foregroundStyle(.black).font(.system(size: 25))
                }).fullScreenCover(isPresented: $shouldShowSettings, onDismiss: reloadPage, content: {
                    SettingsView(dismissalBool: $shouldShowSettings)
                })
                Spacer()
                Text("Task List").font(.system(size: 25))
                Spacer()
                Button(action: {
                    shouldShowCreate.toggle()
                }, label: {
                    Image(systemName: "plus.circle.fill").foregroundStyle(.black).font(.system(size: 25))
                }).fullScreenCover(isPresented: $shouldShowCreate, content: {
                    AddTaskFormView(dueDate: Date(), dismissalBool: $shouldShowCreate)
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
    
    func reloadPage() {
        print("Sending request")
        Services.shared.fetchTasks { (result) in
            self.tasks = result ?? []
        }
    }
}

#Preview {
    ContentView()
}
