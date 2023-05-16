//
//  ViewController.swift
//  QuizApp
//
//  Created by Arben on 3.5.23.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var highestValueLabel: UILabel!
    
    private var finalScore = 0
    private let viewModel = QuizViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apperance()
        setupTableView()
    }
    
    private func apperance() {
        scoreLabel.text = "Score: \(finalScore)"
        highestValueLabel.text = "Score: \(viewModel.highestScore)"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(QuizTableViewCell.nib, forCellReuseIdentifier: QuizTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.bounces = false
    }
    
    private func updateUI() {
        scoreLabel.text = "Score: \(finalScore)"
        tableView.reloadData()
        
        if viewModel.currentQuestionIndex == viewModel.questions.count - 1 {
            nextButton.setTitle("Finish", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
        viewModel.updateHighestScore(finalScore: finalScore)
        highestValueLabel.text = "Score: \(viewModel.highestScore)"
    }
    
    func showRestartAlert() {
        let alert = UIAlertController(title: "Game Over", message: "Do you want to restart the game?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .cancel) { [weak self] _ in
            // Restart the game
            self?.restartGame()
        }
        
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func restartGame() {
        viewModel.resetGame(finalScore: &finalScore)
        updateUI()
        backButton.isEnabled = false
        nextButton.isEnabled = true
    }
    
    @IBAction private func backButton(_ sender: Any) {
        if viewModel.currentQuestionIndex == 0 {
            backButton.isEnabled = false
            nextButton.isEnabled = true
        } else {
            viewModel.currentQuestionIndex -= 1
            updateUI()
        }
        nextButton.isEnabled = true
    }
    
    @IBAction private func nextButton(_ sender: Any) {
        if viewModel.currentQuestionIndex == viewModel.questions.count - 1 {
            backButton.isEnabled = true
            showRestartAlert()
        } else {
            viewModel.currentQuestionIndex += 1
            updateUI()
            backButton.isEnabled = true
            nextButton.isEnabled = true
        }
    }
}

extension QuizViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: QuizTableViewCell.identifier, for: indexPath) as? QuizTableViewCell {
            let answer = viewModel.questions[viewModel.currentQuestionIndex].answers[indexPath.row]
            self.questionLabel.text = viewModel.questions[viewModel.currentQuestionIndex].text
            cell.questionImage.image = answer.image
            if answer.isSelected {
                cell.checkMarkImage.isHidden = false
            } else {
                cell.checkMarkImage.isHidden = true
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.questions[viewModel.currentQuestionIndex].answers.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.checkIfQuestionsHasNotBeenAnswered(indexPath: indexPath, tableView: tableView, finalScore: &finalScore)
        updateUI()
    }
}
