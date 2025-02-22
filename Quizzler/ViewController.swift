//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    var pickedAnswer : Bool = false
    let allQuestions = QuestionBank()
    var questionNumber : Int = 0
    var score : Int = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 2 {
            pickedAnswer = false
        }
        else if sender.tag == 1 {
            pickedAnswer = true
        }
        
        checkAnswer()
        
        questionNumber += 1
        
        nextQuestion()
        
  
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / \(allQuestions.list.count)"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber)
    }
    

    func nextQuestion() {
        if questionNumber < allQuestions.list.count {
             questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        }
        else {
            let alert = UIAlertController(title: "Congratulations!", message: "You've finished the quiz! \n You are awesome!", preferredStyle: .alert)
            let restart = UIAlertAction(title: "Restart", style: .default, handler: { UIAlertAction in
                self.startOver()
            })
            
            alert.addAction(restart)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            score += 1
            ProgressHUD.showSuccess("Correct!")
        }
        else if correctAnswer != pickedAnswer {
            ProgressHUD.showError("Wrong")
        }
        
        
    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
        nextQuestion()
    }
    

    
}
