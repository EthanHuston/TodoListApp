//
//  RadioButton.swift
//  TodoListApp
//
//  Created by Ethan Huston on 5/7/24.
//

import SwiftUI

struct RadioButton: View {
    @Binding private var isSelected: Bool
    private let label: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            circleView
            labelView
        }
        .contentShape(Rectangle())
        .onTapGesture { isSelected = true }
    }
}

//ViewBuilder Extension
extension RadioButton {
    @ViewBuilder var labelView: some View {
        if !label.isEmpty {
            Text(label)
        }
    }
    
    @ViewBuilder var circleView: some View {
        Circle()
            .fill(isSelected ? Color.black : Color.clear)
            .padding(4)
            .overlay(Circle().stroke(Color.black, lineWidth: 2)).frame(width: 20, height: 20)
    }
}

//Initializer Extension
extension RadioButton {
    
    init<V: Hashable>(tag: V, selection: Binding<V?>, label: String = "") {
          self._isSelected = Binding(
            get: { selection.wrappedValue == tag },
            set: { _ in selection.wrappedValue = tag }
          )
          self.label = label
        }
}

//#Preview {
//    RadioButton(isSelected: .constant(true), label: "Radio Button")
//}
