//
//  AddTaskFormView.swift
//  TodoListApp
//
//  Created by Ethan Huston on 5/7/24.
//

import SwiftUI

struct AddTaskFormView: View {
    @State private var todoName: String = ""
    @State private var editing = false
    @State var dueDate: Date
    @Binding var dismissalBool: Bool
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("Create").font(.system(size: 38)).padding()
                Spacer()
            }
            
            Text("To-Do Item Name").font(.system(size: 16)).padding(.leading, 30)
            
            TextField("", text: $todoName) { edit in
                self.editing = edit
            }.textFieldStyle(CustomTextFieldStyle(focused: $editing))
            
            Text("Select Due Date").font(.system(size: 16)).padding(.leading, 30)
            
            //DatePicker("Select Due Date", selection: $dueDate, displayedComponents: .date).labelsHidden()
            CustomDatePicker(selectedDate: dueDate)
            
            HStack {
                Spacer()
                Button(action: {
                    print("Save Settings")
                    dismissalBool = false
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

struct CustomTextFieldStyle: TextFieldStyle {
    @Binding var focused: Bool
    private let grayColor = Color(uiColor: UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1))
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 4).stroke(focused ? Color.black : Color.clear, lineWidth: 3).background(grayColor)
                    
            ).cornerRadius(4).frame(width: 332, height: 43).padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
    }
}

struct CustomDatePicker: View {
    @State private var showPicker = false
    @State var selectedDate: Date
    private let grayColor = Color(uiColor: UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1))

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4).stroke(Color.black).background(grayColor)
            HStack {
                Text(selectedDate.formatted(.dateTime.day().month().year())).font(.system(size: 16)).padding(.horizontal)
                Spacer()
                Image("calendar").padding(.horizontal)
            }
        }.frame(width: 332, height: 43).padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0)).overlay {
            DatePicker(selection: $selectedDate, displayedComponents: .date) {}
                .labelsHidden()
                .contentShape(Rectangle())
                .opacity(0.011)
                .scaleEffect(CGSize(width: 2.8, height: 1.0), anchor: .center)
                .offset(x: 18)
        }
    }
}

//#Preview {
//    AddTaskFormView()
//}
