//
//  SettingsView.swift
//  TodoListApp
//
//  Created by Ethan Huston on 5/7/24.
//

import SwiftUI

//Settings page
struct SettingsView: View {
    
    @State private var selectedFilter: filterOptions? = Services.shared.filterSetting
    @State private var selectedSortBy: sortByOptions? = Services.shared.sortBySetting
    @State private var selectedSortDir: sortDirectionOptions? = Services.shared.sortDirectionSetting
    @Binding var dismissalBool: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("Settings").font(.system(size: 34))
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
                    //Set correct settings in singleton class for api calls
                    Services.shared.filterSetting = selectedFilter!
                    Services.shared.sortBySetting = selectedSortBy!
                    Services.shared.sortDirectionSetting = selectedSortDir!
                    
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

// Enums for differentiating settings states
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
