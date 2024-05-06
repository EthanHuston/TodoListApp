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
                })
                
                VStack(alignment: .leading) {
                    Text(task.taskDescription).font(.system(size: 16, weight: .medium)).padding(0.1)
                    Text("Due: " + task.dueDate).font(.system(size: 14))
                    Text("Created: " + task.createdDate).font(.system(size: 14))
                }.frame(width: 220)
                
                Toggle("", isOn: $task.completed).toggleStyle(CheckboxToggleStyle()).foregroundStyle(.black)
                
                Button(action: {
                    print("Delete task")
                }, label: {
                    Image("delete")
                })
            }
        }
        
    }
}

#Preview {
    TaskView(task: Task(id: "1234", taskDescription: "Grocery Shopping", createdDate: "February 28 2023", dueDate: "March 8 2023", completed: true))
}
