//
//  HabitTrackerPersistenceManager.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 30/04/25.
//

import Foundation
import CoreData

class HabitTrackerPersistenceManager {
    let persistenceManager: NSPersistentContainer
    
    init() {
        self.persistenceManager = NSPersistentContainer(name: "HabitTracker")
        self.persistenceManager.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError(error.localizedDescription)
            }
        }
    }
    
}
