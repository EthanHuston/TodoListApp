//
//  TaskView.swift
//  TodoListApp
//
//  Created by Ethan Huston on 5/6/24.
//

import SwiftUI
import Foundation

struct TaskView: View {
    @State var task: Task
    @State private var shouldShowEdit = false
    var reloadMainPage: () -> Void
    var deleteTask: (Task) -> Void
    private let dateFormatter = DateFormatter()
    
    init(task: Task, reloadMainPage: @escaping () -> Void, deleteTask: @escaping (Task) -> Void) {
        self.task = task
        dateFormatter.dateFormat = "MMM, d, y"
        self.reloadMainPage = reloadMainPage
        self.deleteTask = deleteTask
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5).foregroundStyle(Color(uiColor: UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1))).frame(width: 358, height: 90)
            HStack {
                Button(action: {
                    shouldShowEdit.toggle()
                }, label: {
                    Image("editPen").foregroundStyle(.black).font(.system(size: 30))
                }).fullScreenCover(isPresented: $shouldShowEdit, content: {
                    EditTaskForm(task: task, editing: false,  dueDate: dateFormatter.date(from: task.dueDate) ?? Calendar.current.date(byAdding: .day, value: 4, to: Date())!, dismissalBool: $shouldShowEdit, reloadMainPage: reloadMainPage)
                })
                
                VStack(alignment: .leading) {
                    Text(task.taskDescription).font(.system(size: 16, weight: .medium)).padding(0.1)
                    Text("Due: " + task.dueDate).font(.system(size: 14))
                    Text("Created: " + task.createdDate).font(.system(size: 14))
                }.frame(width: 220)
                
                Toggle("", isOn: $task.completed).toggleStyle(CheckboxToggleStyle()).foregroundStyle(.black)
                
                Button(action: {
                    Services.shared.deleteTask(task: task) { result in
                        deleteTask(task)
                    }
                    
                    
                }, label: {
                    Image("delete")
                })
            }
        }.onChange(of: task.completed) { oldValue, newValue in
            Services.shared.updateTask(task: task) { updatedTask in
                reloadMainPage()
            }
        }
        
    }
}

//#Preview {
//    TaskView(task: Task(id: "1234", taskDescription: "Grocery Shopping", createdDate: "createdDate", dueDate: "dueDate", completed: true))
//}
