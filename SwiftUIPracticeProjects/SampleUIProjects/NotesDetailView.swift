//
//  NotesDetailView.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 30/04/25.
//

import SwiftUI

struct NotesDetailView: View {
    @Environment(\.dismiss) var dismiss
    let noteViewModel: NotesListViewModel
    @State var note: Note
    var body: some View {
        //NavigationView {
            Form {
                TextField("Title", text: $note.title)
                TextEditor(text: $note.content)
                    .frame(height: 300)
            }.navigationTitle("Edit Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        noteViewModel.updateNote(note: note)
                        dismiss()
                    }
                }
            }
        //}
    }
}

#Preview {
    let noteListVM = NotesListViewModel(managedObjectContext: NotesPersistenceManager().persistentContainer.viewContext)
    NotesDetailView(noteViewModel: noteListVM, note: Note(title: "Test", content: "Test"))
}
