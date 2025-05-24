//
//  HabitTrackerView.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 30/04/25.
//

import SwiftUI
import CoreData

struct HabitTrackerView: View {
    @StateObject private var viewModel: HabitTrackerViewModel
    @State private var showAddhabitView = false
    
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: HabitTrackerViewModel(context: context))
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.habits, id: \.id) { habit in
                    NavigationLink {
                        HabitDetailView(viewModel: HabitDetailViewModel(habitEntity: viewModel.getHabitEntityFor(habit: habit)!, context: viewModel.context))
                    } label: {
                        HabitRowView(habit: habit, isCompletedToday: viewModel.isCompletedToday(habit: habit))
                    }
                }.onDelete { indexSet in
                    viewModel.deleteHabit(indexSet)
                }
            }.navigationTitle("My Habits")
                .toolbar(content: {
                    ToolbarItem {
                        Button {
                            self.showAddhabitView.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }

                    }
                }).sheet(isPresented: $showAddhabitView, onDismiss: {
                    viewModel.fetchHabits()
                }, content: {
                    AddHabitView(context: viewModel.context)
                })
                .onAppear {
                    viewModel.fetchHabits()
                }
        }
    }
}

struct HabitRowView: View {
    let habit: Habit
    let isCompletedToday: Bool
    var body: some View {
        VStack(alignment: .leading) {
            Text(habit.title)
                .font(.title)
            HStack {
                Text("Created:")
                    .font(.headline)
                Text(habit.createdAt.formatted(date: .abbreviated, time: .shortened))
                    .font(.subheadline)
                Image(systemName: isCompletedToday ? "checkmark.circle.fill" : "circle")
            }
        }
    }
}

#Preview {
    HabitTrackerView(context: HabitTrackerPersistenceManager().persistenceManager.viewContext)
}
