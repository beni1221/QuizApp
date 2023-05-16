//
//  Question.swift
//  QuizApp
//
//  Created by Arben on 3.5.23.
//

import UIKit

class Question {
    let text: String
    var answers: [Answer]
    var isAnswered: Bool = false
    
    init(text: String, answers: [Answer]) {
        self.text = text
        self.answers = answers
    }
    
    func isAnsweredCorrectly() -> Bool {
        for answer in answers {
            if answer.isSelected && answer.isCorrect {
                return true
            }
        }
        return false
    }
}

class Answer {
    let text: String
    let isCorrect: Bool
    let image: UIImage
    var isSelected = false
    
    init(text: String, isCorrect: Bool, image: UIImage) {
        self.text = text
        self.isCorrect = isCorrect
        self.image = image
    }
}

