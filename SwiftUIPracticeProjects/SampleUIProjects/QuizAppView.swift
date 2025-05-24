//
//  QuizAppView.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 02/05/25.
//

import SwiftUI

struct QuizAppView: View {
    @StateObject private var viewModel: QuizViewModel = QuizViewModel()
    var body: some View {
        NavigationStack {
            if viewModel.isQuizCompleted {
                ResultView(viewModel: viewModel)
            } else {
                VStack {
                    Text(viewModel.questions[viewModel.currentQuestionIndex].text)
                        .font(.headline)
                    ForEach(viewModel.questions[viewModel.currentQuestionIndex].options, id: \.self) { option in
                        Button {
                            viewModel.checkAnswer(selectedAnswer: option)
                        } label: {
                            Text(option)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                    Spacer()
                    
                }.navigationTitle("Quiz App")
                    .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}

#Preview {
    QuizAppView()
}
