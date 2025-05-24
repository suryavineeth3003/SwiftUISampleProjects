//
//  HabitDetailView.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 01/05/25.
//

import SwiftUI

struct HabitDetailView: View {
    @ObservedObject var viewModel: HabitDetailViewModel
    var body: some View {
        Form {
            Section("Habit Details") {
                Text(viewModel.title)
                Text("Started: \(viewModel.createdDate.formatted(date: .abbreviated, time: .shortened))")
            }
            
            Section("Today") {
                Toggle("Completed Today", isOn: Binding(get: {
                    viewModel.isCompletedToday
                }, set: { newValue in
                    viewModel.setCompletionToday(completed: newValue)
                }))
            }
            
            Section("History") {
                ForEach(viewModel.completionDates.sorted(by: >), id: \.self){ date in
                    Text(date.formatted(date: .abbreviated, time: .shortened))
                }
            }
        }
    }
}

#Preview {
    HabitDetailView(viewModel: HabitDetailViewModel(habitEntity: HabitEntity(context: HabitTrackerPersistenceManager().persistenceManager.viewContext), context: HabitTrackerPersistenceManager().persistenceManager.viewContext))
}
