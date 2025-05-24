//
//  Habit.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 01/05/25.
//

import Foundation

struct Habit: Identifiable {
    var id: UUID = UUID()
    var title: String
    var createdAt: Date
    var completions: [Date]
}

extension Habit {
    static func fromEntity(_ entity: HabitEntity) -> Self {
        return .init(
            id: UUID(uuidString: entity.id ?? "") ?? UUID(),
            title: entity.title ?? "",
            createdAt: entity.createdAt ?? Date(),
            completions: entity.completions as? [Date] ?? []
        )
    }
}
