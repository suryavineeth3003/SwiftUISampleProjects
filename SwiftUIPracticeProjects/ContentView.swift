//
//  ContentView.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 17/04/25.
//

import SwiftUI

struct ContentView: View {
    let viewModel: ContentViewModel
    let notesPersistenceManager = NotesPersistenceManager()
    let habitTrackerPersistenceManager = HabitTrackerPersistenceManager()
    let financeTrackerPersistencemanager = FinanceTrackerPersistenceManager()
    var body: some View {
        NavigationStack {
            List(viewModel.projectLevels) { level in
                Section(level.name) {
                    ForEach(level.projects) { project in
                        NavigationLink(project.name) {
                            destinationView(for: project)
                        }
                    }
                }
            }.navigationTitle("Project List")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    
    @ViewBuilder
    func destinationView(for project: Project)-> some View {
        switch project.className {
        case .tipCalculator:
            TipCalculator()
        case .todoList:
            ToDoList()
        case .weatherApp:
            WeatherApp()
        case .movieBrowser:
            MovieBrowser()
        case .notesApp:
            NotesListView(context: notesPersistenceManager.persistentContainer.viewContext)
        case .habitTracker:
            HabitTrackerView(context: habitTrackerPersistenceManager.persistenceManager.viewContext)
        case .quizApp:
            QuizAppView()
        case .finaceTracker:
            FinanceCalculator(viewModel: TransactionListViewModel(context: financeTrackerPersistencemanager.persistenceContainer.viewContext))
        case .recipeApp:
            ReceipeView()
        case .photoGridViewer:
            PhotoGridView()
        default:
            Text("test")
        }
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
