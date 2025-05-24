//
//  ToDoListViewModel.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 17/04/25.
//

import Foundation
import SwiftUI

struct Task: Codable, Identifiable {
    var id = UUID()
    var name:String
    var isCompleted:Bool
}

class ToDoListViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    init() {
        self.getTasks()
    }
    
    func addTask(name: String) {
        guard !name.isEmpty else { return }
        let task = Task(name: name, isCompleted: false)
        tasks.append(task)
        self.save()
    }
    
    func deleteTasks(indexSet: IndexSet) {
        tasks.remove(atOffsets: indexSet)
        self.save()
    }
    
    func toggleCompleted(for task: Task) {
        if let index = tasks.firstIndex(where: {$0.id == task.id}) {
            tasks[index].isCompleted.toggle()
            self.save()
        }
        
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(tasks)
            UserDefaults.standard.setValue(data, forKey: "tasks")
            UserDefaults.standard.synchronize()
        }
        catch {
            
        }
    }
    
    func getTasks() {
        guard let data =  UserDefaults.standard.value(forKey: "tasks") as? Data else {
            return
        }
        do {
            self.tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch {
            
        }
    }
}
