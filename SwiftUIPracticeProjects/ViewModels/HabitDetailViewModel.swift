//
//  HabitDetailViewModel.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 01/05/25.
//

import Foundation
import CoreData

class HabitDetailViewModel: ObservableObject {
    @Published var title: String
    @Published var createdDate: Date
    @Published var completionDates: [Date]
    
    private var habitEntity: HabitEntity
    private let context: NSManagedObjectContext
    
    init( habitEntity: HabitEntity, context: NSManagedObjectContext) {
        self.habitEntity = habitEntity
        self.context = context
        self.title = habitEntity.title ?? ""
        self.createdDate = habitEntity.createdAt ?? Date()
        self.completionDates = habitEntity.completions as? [Date] ?? []
    }
    
    var isCompletedToday: Bool {
        let today = Calendar.current.startOfDay(for: Date())
        return completionDates.contains(today)
    }
    
    func setCompletionToday(completed: Bool) {
        let today = Calendar.current.startOfDay(for: Date())
        if completed {
            completionDates.append(today)
        } else {
            if let dateIndex = completionDates.firstIndex(of: today) {
                completionDates.remove(at: dateIndex)
            }
        }
        habitEntity.completions = completionDates as NSObject
        self.saveContext()
    }
    
    func save() {
        habitEntity.title = title
        habitEntity.createdAt = createdDate
        habitEntity.completions = completionDates as NSObject
        self.saveContext()
    }
    
    func saveContext () {
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch {
            
        }
    }
}
