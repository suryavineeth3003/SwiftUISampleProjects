//
//  NotesListView.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 30/04/25.
//

import SwiftUI
import CoreData

struct NotesListView: View {
    @StateObject private var viewModel: NotesListViewModel
    @State var showDetailView = false
    
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: NotesListViewModel(managedObjectContext: context))
    }
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink {
                        NotesDetailView(noteViewModel: viewModel, note: note)
                    } label: {
                        VStack (alignment: .leading){
                            Text(note.title)
                                .font(.title)
                            Text(note.content)
                                .font(.subheadline)
                                .lineLimit(2)
                        }
                    }
                }.onDelete { indexSet in
                    viewModel.delete(noteAtIndex: indexSet)
                }
            }.navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showDetailView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showDetailView) {
                NotesDetailView(noteViewModel: viewModel, note: Note(title: "", content: ""))
            }
        }
    }
}

#Preview {
    NotesListView(context: NotesPersistenceManager().persistentContainer.viewContext)
}
