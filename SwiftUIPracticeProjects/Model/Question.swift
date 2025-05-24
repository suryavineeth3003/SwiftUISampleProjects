//
//  Question.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 02/05/25.
//

import Foundation

struct Question: Identifiable {
    var id: UUID = UUID()
    var text: String
    var correctAnswer: String
    var options: [String]
}
