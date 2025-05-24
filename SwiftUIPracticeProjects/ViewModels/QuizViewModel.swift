//
//  QuizViewModel.swift
//  SwiftUIPracticeProjects
//
//  Created by Surya Vineeth on 02/05/25.
//

import Foundation

class QuizViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var timeRemaining = 10
    var answerCount: Int = 0
    var isQuizCompleted: Bool {
        return currentQuestionIndex == questions.count
    }
    
    var currentScore: Double {
        return Double((answerCount / questions.count) * 100)
    }
    
    init() {
        self.questions = [
            Question(text: "What is the capital of France?", correctAnswer: "Paris", options: ["Paris", "London", "Rome", "Berlin"]),
            Question(text: "2 + 2 equals?", correctAnswer: "4", options: ["3", "4", "5", "2"]),
            Question(text: "Swift is developed by?", correctAnswer: "Apple", options: ["Google", "Apple", "Facebook", "Amazon"]),
            Question(text: "What is the latest Xcode version?", correctAnswer: "16", options: ["15", "17", "16", "18"])
        ]
        self.startTimer()
    }
    
    func startTimer() {
        
    }
    
    func checkAnswer(selectedAnswer: String) {
        let question = self.questions[self.currentQuestionIndex]
        if question.correctAnswer == selectedAnswer {
            answerCount += 1
        }
        currentQuestionIndex += 1
    }
    
    func restartQuiz() {
        currentQuestionIndex = 0
        answerCount = 0
    }
}
