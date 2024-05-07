//
//  Services.swift
//  TodoListApp
//
//  Created by Ethan Huston on 5/7/24.
//

import Foundation

class Services {
    static let shared = Services()

    private let baseURL = URL(string: "http://localhost:3000")!

    private init() {}

    func fetchTasks(completion: @escaping ([Task]?) -> Void) {
        let url = baseURL.appendingPathComponent("/tasks")
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }

            do {
                let tasks = try JSONDecoder().decode([Task].self, from: data)
                completion(tasks)
            } catch {
                print("Failed to decode response: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }

    // Add other API methods here (e.g., createTask, updateTask, deleteTask)
}
