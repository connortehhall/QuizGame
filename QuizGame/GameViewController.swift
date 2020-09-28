//
//  GameViewController.swift
//  QuizGame
//
//  Created by Connor Teh-Hall on 28/09/20.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var gameModels = [Question]()
    var currentQuestion: Question?
    var cntr = 0
    
    @IBOutlet var label: UILabel!
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setupQuestions()
        configureUI(question: gameModels.first!)
    }
    
    private func configureUI(question: Question) {
        label.text = question.text
        currentQuestion = question
        table.reloadData()
    }
    
    private func checkAnswer(answer: Answer, question: Question) -> Bool {
        return question.answers.contains(where: {$0.text == answer.text}) && answer.correct == true
    }
    
    private func setupQuestions() {
        gameModels.append(Question(text: "What is the name for the Jewish New Year?", answers: [
            Answer(text: "Hanukkah", correct: false),
            Answer(text: "Yom Kippur", correct: false),
            Answer(text: "Kwanza", correct: false),
            Answer(text: "Rosh Hashanah", correct: true)
        ]))
        
        gameModels.append(Question(text: "How many blue stripes are there on the U.S. flag?", answers: [
            Answer(text: "6", correct: false),
            Answer(text: "13", correct: false),
            Answer(text: "0", correct: true),
            Answer(text: "7", correct: false)
        ]))
        
        gameModels.append(Question(text: "Which one of these characters is not friends with Harry Potter?", answers: [
            Answer(text: "Ron Weasley", correct: false),
            Answer(text: "Neville Longbottom", correct: false),
            Answer(text: "Draco Malfoy", correct: true),
            Answer(text: "Hermione Granger", correct: false)
        ]))
        
        gameModels.append(Question(text: "What is the color of Donald Duck’s bowtie?", answers: [
            Answer(text: "Red", correct: true),
            Answer(text: "Yellow", correct: false),
            Answer(text: "Blue", correct: false),
            Answer(text: "White", correct: false)
        ]))
        
        gameModels.append(Question(text: "What was the name of the band Lionel Richie was a part of?", answers: [
            Answer(text: "King Harvest", correct: false),
            Answer(text: "Spectrums", correct: false),
            Answer(text: "Commodores", correct: true),
            Answer(text: "The Marshall Tucker Band", correct: false)
        ]))
        
        gameModels.append(Question(text: "Which animal does not appear in the Chinese zodiac?", answers: [
            Answer(text: "Dragon", correct: false),
            Answer(text: "Rabbit", correct: false),
            Answer(text: "Dog", correct: false),
            Answer(text: "Hummingbird", correct: true)
        ]))
        
        gameModels.append(Question(text: "Which country held the 2016 Summer Olympics?", answers: [
            Answer(text: "China", correct: false),
            Answer(text: "Ireland", correct: false),
            Answer(text: "Brazil", correct: true),
            Answer(text: "Italy", correct: false)
        ]))
        
        gameModels.append(Question(text: "Which planet is the hottest?", answers: [
            Answer(text: "Venus", correct: true),
            Answer(text: "Saturn", correct: false),
            Answer(text: "Mercury", correct: false),
            Answer(text: "Mars", correct: false)
        ]))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let question = currentQuestion else {
            return
        }
        
        let answer = question.answers[indexPath.row]
        
        if checkAnswer(answer: answer, question: question) {
            // correct
            cntr += 1
        }
        if let index = gameModels.firstIndex(where: { $0.text == question.text}) {
            // check if last question or not
            if index < gameModels.count - 1 {
                // next question
                let nextQuestion  = gameModels[index+1]
                configureUI(question: nextQuestion)
            }
            else {
                // end game
                let alert = UIAlertController(title: "Done", message: "Your score was \(cntr) / \(gameModels.count)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                present(alert, animated: true)
            }
        }
    }

}

struct Question {
    let text: String
    let answers: [Answer]
}

struct Answer {
    let text: String
    let correct: Bool
}
