//
//  RecepieViewModel.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 03/05/25.
//

import Foundation
import SwiftUI

class RecepieViewModel: ObservableObject {
    @Published var recepies: [Recepie] = []
    @Published var navigationPath =  NavigationPath()
    init () {
        recepies = [
            Recepie(id: UUID(), title: "Pasta", description: "Delicious Italian Pasta.", ingredients: ["Pasta", "Tomato Sauce", "Cheese"]),
            Recepie(id: UUID(), title: "Pizza", description: "Homemade Pizza.", ingredients: ["Dough", "Tomato", "Cheese"]),
            Recepie(id: UUID(), title: "Salad", description: "Healthy Salad.", ingredients: ["Lettuce", "Tomato", "Cucumber"])
        ]
    }
    
    func selectedRecepie(by id: UUID) {
        if let recipie =  self.recepies.filter({$0.id == id}).first {
            navigationPath.append(recipie)
        }
    }
}
