//
//  ResultView.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 02/05/25.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject var viewModel: QuizViewModel
    var body: some View {
        VStack {
            Text("Quiz Completed")
                .font(.largeTitle)
            Text("Your score is = \(viewModel.currentScore)")
                .font(.title2)
            
            Button {
                viewModel.restartQuiz()
            } label: {
                Text("Restart Quiz")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    ResultView(viewModel: QuizViewModel())
}
