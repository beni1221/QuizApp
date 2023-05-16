//
//  QuizViewModel.swift
//  QuizApp
//
//  Created by Arben on 5.5.23.
//

import UIKit

class QuizViewModel {
    var currentQuestionIndex = 0
    var highestScore: Int {
        get {
            return UserDefaults.standard.integer(forKey: "HighestScore")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "HighestScore")
        }
    }
    let questions = [
        Question(text: "What is the flag of France?", answers: [
            Answer(text: "Paris", isCorrect: true, image: UIImage(named: "france") ?? UIImage()),
            Answer(text: "Washington", isCorrect: false, image: UIImage(named: "united-states") ?? UIImage()),
            Answer(text: "Rome", isCorrect: false, image: UIImage(named: "italy") ?? UIImage())
        ]),
        Question(text: "What is the flag of Turkey?", answers: [
            Answer(text: "Madrid", isCorrect: false, image: UIImage(named: "spain") ?? UIImage()),
            Answer(text: "Rome", isCorrect: false, image: UIImage(named: "italy") ?? UIImage()),
            Answer(text: "Istanbul", isCorrect: true, image: UIImage(named: "turkey") ?? UIImage())
        ]),
        Question(text: "What is the flag of Germany?", answers: [
            Answer(text: "Paris", isCorrect: false, image: UIImage(named: "france") ?? UIImage()),
            Answer(text: "Berlin", isCorrect: true, image: UIImage(named: "germany") ?? UIImage()),
            Answer(text: "Rome", isCorrect: false, image: UIImage(named: "italy") ?? UIImage())
        ]),
        Question(text: "What is the flag of USA?", answers: [
            Answer(text: "Paris", isCorrect: false, image: UIImage(named: "france") ?? UIImage()),
            Answer(text: "Madrid", isCorrect: false, image: UIImage(named: "spain") ?? UIImage()),
            Answer(text: "Washington", isCorrect: true, image: UIImage(named: "united-states") ?? UIImage())
        ]),
        Question(text: "What is the flag of Italy?", answers: [
            Answer(text: "Rome", isCorrect: true, image: UIImage(named: "italy") ?? UIImage()),
            Answer(text: "London", isCorrect: false, image: UIImage(named: "united-kingdom") ?? UIImage()),
            Answer(text: "Paris", isCorrect: false, image: UIImage(named: "france") ?? UIImage())
        ])
    ]
    
    init() {
        self.highestScore = UserDefaults.standard.integer(forKey: "HighestScore")
    }
    
    func updateHighestScore(finalScore: Int) {
        if finalScore > highestScore {
            highestScore = finalScore
        }
    }
    
    func resetGame(finalScore: inout Int) {
        currentQuestionIndex = 0
        finalScore = 0
        for i in 0..<questions.count {
            questions[i].isAnswered = false
            
        }
    }
    
    func checkIfQuestionsHasNotBeenAnswered(indexPath: IndexPath, tableView: UITableView, finalScore: inout Int) {
        let selectedAnswer = questions[currentQuestionIndex].answers[indexPath.row]
        
        if selectedAnswer.isSelected {
            // Deselect the answer
            selectedAnswer.isSelected = false
            finalScore -= selectedAnswer.isCorrect ? 1 : 0
            questions[currentQuestionIndex].isAnswered = false
        } else {
            // Deselect previously selected answer if any
            if let previousAnswer = questions[currentQuestionIndex].answers.first(where: { $0.isSelected }) {
                previousAnswer.isSelected = false
                finalScore -= previousAnswer.isCorrect ? 1 : 0
                questions[currentQuestionIndex].isAnswered = false
            }
            
            // Select the new answer
            selectedAnswer.isSelected = true
            finalScore += selectedAnswer.isCorrect ? 1 : 0
            questions[currentQuestionIndex].isAnswered = true
        }
        
        tableView.reloadData()
    }
}
