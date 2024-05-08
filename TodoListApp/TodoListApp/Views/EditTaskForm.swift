//
//  EditTaskForm.swift
//  TodoListApp
//
//  Created by Ethan Huston on 5/8/24.
//

import SwiftUI

struct EditTaskForm: View {
    @State var task: Task
    @State  var editing = false
    @State  var dueDate: Date
    @Binding var dismissalBool: Bool
    
    var reloadMainPage: () -> Void
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("Edit").font(.system(size: 38)).padding()
                Spacer()
            }
            
            Text("To-Do Item Name").font(.system(size: 16)).padding(.leading, 30)
            
            TextField("", text: $task.taskDescription) { edit in
                self.editing = edit
            }.textFieldStyle(CustomTextFieldStyle(focused: $editing))
            
            Text("Select Due Date").font(.system(size: 16)).padding(.leading, 30)
            CustomDatePicker(selectedDate: $dueDate)
            
            HStack {
                Spacer()
                Button(action: {
                    task.dueDate = dueDate.formatted(.dateTime.day().month().year())
                    Services.shared.updateTask(task: task) { updatedTask in
                        reloadMainPage()
                        dismissalBool = false
                    }
                    
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4).foregroundStyle(.black).frame(width: 80, height: 40)
                        Text("Save").foregroundStyle(.white)
                    }
                    
                })
                Spacer()
            }.padding(40)
            Spacer()
        }
    }
}

//#Preview {
//    EditTaskForm()
//}
