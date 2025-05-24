//
//  Recepie.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 03/05/25.
//

import Foundation

struct Recepie: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var description: String
    var ingredients: [String]
}
