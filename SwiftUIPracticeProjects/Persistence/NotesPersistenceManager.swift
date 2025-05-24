//
//  Notes.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 30/04/25.
//

import Foundation
import CoreData

class NotesPersistenceManager {
    var persistentContainer: NSPersistentContainer!
    
    init() {
        persistentContainer = NSPersistentContainer(name: "NotesModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
