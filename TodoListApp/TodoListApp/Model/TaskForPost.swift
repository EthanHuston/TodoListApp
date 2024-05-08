//
//  TaskForPost.swift
//  TodoListApp
//
//  Created by Ethan Huston on 5/8/24.
//

import Foundation

struct TaskForPost: Codable, Identifiable {
    var id: String
    var taskDescription: String
    var dueDate: String
    var completed: Bool
}
