//
//  EditTaskForm.swift
//  TodoListApp
//
//  Created by Ethan Huston on 5/8/24.
//

import SwiftUI

struct EditTaskForm: View {
    @State private var todoName: String = ""
    @State private var editing = false
    @State private var dueDate = Date.now
    //@Binding var dismissalBool: Bool
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("Edit").font(.system(size: 38)).padding()
                Spacer()
            }
            
            Text("To-Do Item Name").font(.system(size: 16)).padding(.leading, 30)
            
            TextField("", text: $todoName) { edit in
                self.editing = edit
            }.textFieldStyle(CustomTextFieldStyle(focused: $editing))
            
            Text("Select Due Date").font(.system(size: 16)).padding(.leading, 30)
            CustomDatePicker()
            
            HStack {
                Spacer()
                Button(action: {
                    print("Save Settings")
                   // dismissalBool = false
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

#Preview {
    EditTaskForm()
}
