//
//  AddTaskFormView.swift
//  TodoListApp
//
//  Created by Ethan Huston on 5/7/24.
//

import SwiftUI

struct AddTaskFormView: View {
    @State private var todoName: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("Create").font(.system(size: 38)).padding()
                Spacer()
            }
            Text("To-Do Item Name").font(.system(size: 16)).padding(.leading)
            TextField("", text: $todoName).background(RoundedRectangle(cornerRadius: 4).padding(.horizontal).foregroundColor(Color(uiColor: UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1))).frame(width: 332, height: 43)).padding(.horizontal).frame(width: 332, height: 43)
            Spacer()
        }
    }
}

#Preview {
    AddTaskFormView()
}
