//
//  AddHabitView.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 01/05/25.
//

import SwiftUI
import CoreData

struct AddHabitView: View {
    @StateObject private var viewModel: AddHabitViewModel
    @Environment(\.dismiss) var dismiss
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: AddHabitViewModel(context: context))
    }
    var body: some View {
        NavigationView{
            Form {
                TextField("Habit Name", text: $viewModel.habitName)
            }.navigationTitle("Add Habit")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            viewModel.addHabit()
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
        }
    }
}

#Preview {
    AddHabitView(context: HabitTrackerPersistenceManager().persistenceManager.viewContext)
}
