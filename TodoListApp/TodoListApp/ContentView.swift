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
                //Settings button
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
                //Add task button
                Button(action: {
                    shouldShowCreate.toggle()
                }, label: {
                    Image(systemName: "plus.circle.fill").foregroundStyle(.black).font(.system(size: 25))
                }).fullScreenCover(isPresented: $shouldShowCreate, onDismiss: reloadPage, content: {
                    AddTaskFormView(dueDate: Date(), dismissalBool: $shouldShowCreate)
                })
            }
            //Scrollview filled with current tasks
            ScrollView {
                VStack {
                    ForEach(tasks) { task in
                        TaskView(task: task, reloadMainPage: reloadPage, deleteTask: removeTask).padding(.top, 5)
                    }
                }
            }
            
        }
        .padding().onAppear(perform: {
            //Load tasks on app load
            Services.shared.fetchTasks { (result) in
                self.tasks = result ?? []
            }
        })
    }
    
    //Refills the tasks array with any new changes in settings or content. Refreshing the view.
    func reloadPage() {
        Services.shared.fetchTasks { (result) in
            self.tasks.removeAll()
            self.tasks = result ?? []
        }
    }
    
    //Remove task from app memory, no need to reload on delete
    func removeTask(task: Task) {
        
        withAnimation(.default) {
            self.tasks.remove(at: self.tasks.firstIndex(where: { taskToCheck in
                taskToCheck.id == task.id
            })!)
        }
       
    }
}

#Preview {
    ContentView()
}
