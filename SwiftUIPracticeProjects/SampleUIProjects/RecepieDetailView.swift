//
//  RecepieDetailView.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 03/05/25.
//

import SwiftUI

struct RecepieDetailView: View {
    let recepie: Recepie
    var body: some View {
        Text(recepie.title)
            .font(.largeTitle)
        Text(recepie.description)
            .font(.body)
        Text("Ingredients:")
            .font(.headline)
        ForEach(recepie.ingredients, id: \.self) { ingredient in
            Text("- \(ingredient)")
        }
    }
}

#Preview {
    RecepieDetailView(recepie: Recepie(title: "", description: "", ingredients: []))
}
