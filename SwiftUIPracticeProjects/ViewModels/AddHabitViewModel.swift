//
//  AddHabitViewModel.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 01/05/25.
//

import Foundation
import CoreData

class AddHabitViewModel: ObservableObject {
    @Published var habitName: String = ""
    private let context : NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addHabit() {
        guard !habitName.isEmpty else { return }
        let entity = HabitEntity(context: self.context)
        entity.id = UUID().uuidString
        entity.title = self.habitName
        entity.createdAt = Date()
        entity.completions = NSArray()
        saveContext()
    }
    
    func saveContext () {
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
