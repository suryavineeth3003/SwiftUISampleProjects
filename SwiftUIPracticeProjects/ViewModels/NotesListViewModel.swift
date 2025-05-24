//
//  NotesListViewModel.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 30/04/25.
//

import Foundation
import CoreData

class NotesListViewModel: ObservableObject {
    @Published var notes: [Note] = []
    private let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        self.fetchNotes()
    }
    
    func fetchNotes() {
        let fetchRequest = NoteEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        do {
           let notesFromDB = try self.managedObjectContext.fetch(fetchRequest)
            self.notes = notesFromDB.map({Note(id: UUID(uuidString: $0.id ?? "") ?? UUID(), title: $0.title ?? "", content: $0.content ?? "")})
        } catch {
            
        }
    }
    
    func addNote(note: Note) {
        notes.append(note)
        let noteEntity = NoteEntity(context: self.managedObjectContext)
        noteEntity.id = note.id.uuidString
        noteEntity.title = note.title
        noteEntity.content = note.content
        noteEntity.createdAt = Date()
        self.saveContext()
    }
    
    func updateNote(note: Note) {
        if notes.contains(where: {$0.id == note.id}) {
            let index = notes.firstIndex { existingNote in
                existingNote.id == note.id
            }
            guard let index = index else {
                return
            }
            notes[index] = note
            let fetchRequest = NoteEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", note.id.uuidString)
            do {
                let noteEntity = try self.managedObjectContext.fetch(fetchRequest).first
                noteEntity?.title = note.title
                noteEntity?.content = note.content
                self.saveContext()
            } catch {
                
            }
        } else {
            self.addNote(note: note)
        }
}
    
    func delete(noteAtIndex: IndexSet) {
        let note = notes[noteAtIndex.first!]
        notes.remove(atOffsets: noteAtIndex)
        let fetchRequest = NoteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", note.id.uuidString)
        do {
            let noteEntity = (try self.managedObjectContext.fetch(fetchRequest).first)!
            self.managedObjectContext.delete(noteEntity)
            self.saveContext()
        } catch {
            
        }
    }
    
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            
        }
    }
}
