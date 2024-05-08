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
    
    var filterSetting: filterOptions = .all
    var sortBySetting: sortByOptions = .due
    var sortDirectionSetting: sortDirectionOptions = .ascending

    private init() {}

    
    //Fetch All tasks. Utilizes current settings to retrieve correct set of tasks
    func fetchTasks(completion: @escaping ([Task]?) -> Void) {
        
        var components = URLComponents(url: baseURL.appendingPathComponent("/tasks"), resolvingAgainstBaseURL: true)
        var queryItems = [URLQueryItem]()
        
        if filterSetting != .all {
            if filterSetting == .complete {
                queryItems.append(URLQueryItem(name: "completed", value: "true"))
            } else {
                queryItems.append(URLQueryItem(name: "completed", value: "false"))
            }
        }
        
        if sortBySetting == .due {
            if sortDirectionSetting == .ascending {
                queryItems.append(URLQueryItem(name: "sort_by", value: "+dueDate"))
            } else {
                queryItems.append(URLQueryItem(name: "sort_by", value: "-dueDate"))
            }
        } else {
            if sortDirectionSetting == .ascending {
                queryItems.append(URLQueryItem(name: "sort_by", value: "+createdDate"))
            } else {
                queryItems.append(URLQueryItem(name: "sort_by", value: "-createdDate"))
            }
        }
        
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
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
    
    //Create task function for adding tasks
    func createTask(taskDescription: String, dueDate: String, completed: Bool, completion: @escaping (Task?) -> Void) {
        
        let url = baseURL.appendingPathComponent("/tasks")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newTask = TaskForPost(id: UUID().uuidString, taskDescription: taskDescription, dueDate: dueDate, completed: completed)
        guard let jsonData = try? JSONEncoder().encode(newTask) else {
            print("Failed to encode new task")
            completion(nil)
            return
        }
        
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            do {
                let createdTask = try JSONDecoder().decode(Task.self, from: data)
                completion(createdTask)
            } catch {
                print("Failed to decode return data: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    //Update a task
    func updateTask(task: Task, completion: @escaping (Task?) -> Void) {
        
        let url = baseURL.appendingPathComponent("/tasks/\(task.id)")
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let updatedTask = Task(id: task.id, taskDescription: task.taskDescription, createdDate: task.createdDate, dueDate: task.dueDate, completed: task.completed)
        guard let jsonData = try? JSONEncoder().encode(updatedTask) else {
            print("Failed to encode task")
            completion(nil)
            return
        }
        
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            do {
                let updatedTask = try JSONDecoder().decode(Task.self, from: data)
                completion(updatedTask)
            } catch {
                print("Failed to decode response: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    //Delete a task
    func deleteTask(taskId: String, completion: @escaping (Bool) -> Void) {
        let url = baseURL.appendingPathComponent("/tasks/\(taskId)")
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error deleting the task: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                completion(false)
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(true)
            } else {
                print("Unex[ected status code: \(httpResponse.statusCode)")
                completion(false)
            }
        }
    }
}
