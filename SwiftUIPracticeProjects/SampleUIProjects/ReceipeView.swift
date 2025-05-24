//
//  ReceipeView.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 03/05/25.
//

import SwiftUI

struct ReceipeView: View {
    @StateObject private var viewModel = RecepieViewModel()
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            List(viewModel.recepies) { recepie in
                NavigationLink(recepie.title, value: recepie)
            }
            .navigationDestination(for: Recepie.self) { recepie in
                RecepieDetailView(recepie: recepie)
            }
        }
    }
}

#Preview {
    ReceipeView()
}
