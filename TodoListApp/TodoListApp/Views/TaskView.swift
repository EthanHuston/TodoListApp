//
//  TaskView.swift
//  TodoListApp
//
//  Created by Ethan Huston on 5/6/24.
//

import SwiftUI

struct TaskView: View {
    @State var task: Task
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5).foregroundStyle(Color(uiColor: UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1))).frame(width: 358, height: 90)
            HStack {
                Button(action: {
                    print("Go to edit page")
                }, label: {
                    Image("editPen").foregroundStyle(.black).font(.system(size: 30))
                }).padding()
                
                VStack(alignment: .leading) {
                    Text(task.taskDescription).fontWeight(.semibold)
                    Text("Due: " + task.dueDate)
                    Text("Created: " + task.createdDate)
                }
                
                Toggle("", isOn: $task.completed).toggleStyle(CheckboxToggleStyle()).foregroundStyle(.black).padding()
                
                Button(action: {
                    print("Delete task")
                }, label: {
                    Image(systemName: "trash.fill").foregroundStyle(.black)
                })
            }
        }
        
    }
}

#Preview {
    TaskView(task: Task(id: "1234", taskDescription: "Preview Task", createdDate: "May 5, 2024", dueDate: "May 8 2024", completed: false))
}
