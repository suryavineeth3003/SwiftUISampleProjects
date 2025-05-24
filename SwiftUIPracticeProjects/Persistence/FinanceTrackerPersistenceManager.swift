//
//  FinanceTrackerPersistenceManager.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 03/05/25.
//

import Foundation
import CoreData

class FinanceTrackerPersistenceManager {
    let persistenceContainer: NSPersistentContainer
    init() {
        self.persistenceContainer = NSPersistentContainer(name: "FinanceTracker")
        self.loadPersistentStores()
    }
    
    func loadPersistentStores()  {
        self.persistenceContainer.loadPersistentStores { desc, error in
            if error != nil {
                //success
            }
        }
    }
}
