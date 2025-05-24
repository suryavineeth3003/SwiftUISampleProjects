//
//  ToDoList.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 17/04/25.
//

import SwiftUI

/*
 -----------------------------
 | [ ] Buy groceries         |
 | [✓] Read SwiftUI book     |
 -----------------------------
 | [ + Add Task... ]         |
 -----------------------------
 
 */

struct ToDoList: View {
    @StateObject private var viewModel: ToDoListViewModel = ToDoListViewModel()
    @State private var taskName: String = ""
    var body: some View {
        List {
            Section("Tasks") {
                ForEach($viewModel.tasks) { $task  in
//                    Toggle(isOn: $task.isCompleted, label: {
//                        Text("\(task.name)")
//                    }).onChange(of: task.isCompleted) {
//                        viewModel.toggleCompleted(for: task)
//                    }
                    HStack {
                        Image(systemName: task.isCompleted ?"checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                viewModel.toggleCompleted(for: task)
                            }
                        Text(task.name)
                            .strikethrough(task.isCompleted)
                    }
                }
//                .onDelete(perform: { indexSet in
//                    viewModel.deleteTasks(indexSet: indexSet)
//                })
            }
            
            Section {
                VStack {
                    TextField("Enter task name", text: $taskName)
                    Button("Add Task") {
                        viewModel.addTask(name: taskName)
                    }.padding()
                }
            }
        }
    }
}

#Preview {
    ToDoList()
}
