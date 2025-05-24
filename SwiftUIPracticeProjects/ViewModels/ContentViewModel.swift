//
//  ContentViewModel.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 17/04/25.
//

import Foundation

enum ProjectClass: String {
    case tipCalculator = "TipCalculator"
    case todoList = "TodoList"
    case weatherApp = "WeatherApp"
    case unitConverter = "UnitConverter"
    case movieBrowser = "MovieBrowser"
    case notesApp = "NotesApp"
    case habitTracker = "HabitTracker"
    case quizApp = "QuizApp"
    case chatApp = "ChatApp"
    case finaceTracker = "FinanceTracker"
    case recipeApp = "RecipeApp"
    case photoGridViewer = "PhotoGridViewer"
    case calendarApp = "CalendarApp"
}

struct Level: Identifiable {
    let id = UUID()
    let name: String
    let projects: [Project]
}

struct Project: Identifiable {
    let id = UUID()
    let name: String
    let className: ProjectClass
}

class ContentViewModel {
    var projectLevels: [Level] = []
    
    init() {
        let beginner = Level(name: "Beginner", projects: [
            Project(name: "Tip Calculator", className: .tipCalculator),
            Project(name: "To-Do List", className: .todoList),
            Project(name: "Simple Weather UI", className: .weatherApp),
            Project(name: "Unit Converter", className: .unitConverter)
        ])
        
        let intermediate = Level(name: "Intermediate", projects: [
            Project(name: "Movie Browser", className: .movieBrowser),
            Project(name: "Notes App", className: .notesApp),
            Project(name: "Habit Tracker", className: .habitTracker),
            Project(name: "Quiz App", className: .quizApp)
        ])
        
        
        let advanced = Level(name: "Advanced", projects: [
            Project(name: "Chat App", className: .chatApp),
            Project(name: "Finance Tracker", className: .finaceTracker),
            Project(name: "Recipe App", className: .recipeApp),
            Project(name: "Photo Grid", className: .photoGridViewer),
            Project(name: "Calendar App", className: .calendarApp)
        ])
        
        self.projectLevels.append(beginner)
        self.projectLevels.append(intermediate)
        self.projectLevels.append(advanced)
    }
}
