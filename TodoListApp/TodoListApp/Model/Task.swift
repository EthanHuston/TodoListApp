//
//  Task.swift
//  TodoListApp
//
//  Created by Ethan Huston on 5/6/24.
//

import Foundation
import SwiftUI

//Struct for decoding and encoding a Task
struct Task: Codable, Identifiable {
    let id: String
    var taskDescription: String
    let createdDate: String
    var dueDate: String
    var completed: Bool
}
