//
//  TaskForPost.swift
//  TodoListApp
//
//  Created by Ethan Huston on 5/8/24.
//

import Foundation

//Struct for encoding a task that is being added request body is different than result body.
struct TaskForPost: Codable, Identifiable {
    var id: String
    var taskDescription: String
    var dueDate: String
    var completed: Bool
}
