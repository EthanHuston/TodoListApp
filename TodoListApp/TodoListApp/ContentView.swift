//
//  ContentView.swift
//  TodoListApp
//
//  Created by Ethan Huston on 5/6/24.
//

import SwiftUI

struct ContentView: View {
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
                
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
