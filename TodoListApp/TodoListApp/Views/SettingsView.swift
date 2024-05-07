//
//  SettingsView.swift
//  TodoListApp
//
//  Created by Ethan Huston on 5/7/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedFilter: filterOptions? = .all
    @State private var selectedSortBy: sortByOptions? = .due
    @State private var selectedSortDir: sortDirectionOptions? = .ascending
    @Binding var dismissalBool: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("SETTINGS").font(.system(size: 34))
                Spacer()
            }
            
            Group {
                Text("Filters").font(.system(size: 20)).padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 0))
                RadioButton(tag: .all, selection: $selectedFilter, label: "All").padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                RadioButton(tag: .complete, selection: $selectedFilter, label: "Complete").padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 0))
                RadioButton(tag: .uncomplete, selection: $selectedFilter, label: "Uncomplete").padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 0))
            }
            Group {
                Text("Sort By").font(.system(size: 20)).padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 0))
                RadioButton(tag: .due, selection: $selectedSortBy, label: "Due").padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                RadioButton(tag: .created, selection: $selectedSortBy, label: "Created").padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 0))
            }

            Group {
                Text("Sort Date Direction").font(.system(size: 20)).padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 0))
                RadioButton(tag: .ascending, selection: $selectedSortDir, label: "Ascending").padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                RadioButton(tag: .descending, selection: $selectedSortDir, label: "Descending").padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 0))
            }
            
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
            }.padding()
            Spacer()
        }
    }
}

enum filterOptions {
    case all
    case complete
    case uncomplete
}
enum sortByOptions {
    case due
    case created
}
enum sortDirectionOptions {
    case ascending
    case descending
}

//#Preview {
//    SettingsView()
//}