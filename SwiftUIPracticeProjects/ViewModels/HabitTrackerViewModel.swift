//
//  HabitTrackerViewModel.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 30/04/25.
//

import Foundation
import CoreData

class HabitTrackerViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func isCompletedToday(habit: Habit) -> Bool {
        let today = Calendar.current.startOfDay(for: Date())
        return habit.completions.contains(today)
    }
    
    func fetchHabits() {
        let fetchRequest: NSFetchRequest<HabitEntity> = HabitEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \HabitEntity.createdAt, ascending: false)]
        do {
            let habitsFromDB = try context.fetch(fetchRequest)
            habits = habitsFromDB.map({Habit.fromEntity($0)})
        } catch {
            
        }
    }
    
    func deleteHabit(_ indexSet: IndexSet) {
       let habit = habits.remove(at: indexSet.first!)
       let fetchRequest: NSFetchRequest<HabitEntity> = HabitEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", habit.id.uuidString)
        do {
            guard let habitEntityToDelete = try context.fetch(fetchRequest).first else {
                return
            }
            context.delete(habitEntityToDelete)
            self.saveContext()
        } catch {
            
        }
    }
    
    func saveContext () {
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch {
            
        }
    }
    
    func getHabitEntityFor(habit: Habit) -> HabitEntity? {
        let fetchRequest: NSFetchRequest<HabitEntity> = HabitEntity.fetchRequest()
         fetchRequest.predicate = NSPredicate(format: "id == %@", habit.id.uuidString)
         do {
             guard let habitEntity = try context.fetch(fetchRequest).first else {
                 return nil
             }
             return habitEntity
         } catch {
             
         }
        return nil
    }
}
