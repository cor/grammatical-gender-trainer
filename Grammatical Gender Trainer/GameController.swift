//
//  GameController.swift
//  Grammatical Gender Trainer
//
//  Created by Cor Pruijs on 24-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    
    // MARK: Stat label outlets
    @IBOutlet weak var remainingWordsLabel: UILabel!
    @IBOutlet weak var remainingRoundsLabel: UILabel!
    @IBOutlet weak var timeRunningLabel: UILabel!
    @IBOutlet weak var currentWordLabel: UILabel!
    @IBOutlet weak var currentGenderLabel: UILabel!
    @IBOutlet weak var wordProgressBar: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var currentWordView: UIView!
    
    // MARK: Button outlets
    @IBOutlet weak var masculineButton: UIButton!
    @IBOutlet weak var feminineButton: UIButton!
    @IBOutlet weak var neuterButton: UIButton!
    
    
    
    let feedbackColors: [Bool: UIColor] = [true: UIColor.greenColor(), false: UIColor.redColor()]
    let feedbackTimes: [Bool: NSTimeInterval] = [true: NSTimeInterval(0.5), false: NSTimeInterval(2)]
    
    var words: [Word]!
    var game: Game!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        game = Game(words: words)
        currentGenderLabel.alpha = 0
        game.start()
        updateView()
        
        NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector: Selector("updateTimeLabel"), userInfo: nil, repeats: true)
    }
    
    @IBAction func genderButtonPressed(sender: UIButton) {
        
        // use the button's Restoration ID to get the Gender and use the Game model's answer function
        if let identifier = sender.restorationIdentifier {
            
            var result: (correct: Bool, correctGender: Gender) = (false, Gender.Neuter)
            
            switch identifier {
            case "Masculine": result = game.answer(Gender.Masculine)
            case "Feminine": result = game.answer(Gender.Feminine)
            case "Neuter": result = game.answer(Gender.Neuter)
            default: println("ERROR: invalid Restoration Identifier")
            }
           
            giveFeedback(result)
        }
        
        
    }
    
    func giveFeedback(result: (correct: Bool, correctGender: Gender)) {
        
        enableButtons(false)
        currentGenderLabel.alpha = 1
        UIView.animateWithDuration(feedbackTimes[result.correct]!,
            animations: {
                self.currentWordView.backgroundColor = self.feedbackColors[result.correct]
                self.currentWordView.backgroundColor = UIColor.whiteColor()
                self.currentWordLabel.alpha = 0
                self.currentGenderLabel.alpha = 0
                
                // show the correct answer by making that button feedbackColors[true] color
                if !result.correct {
                    switch result.correctGender {
                    case .Masculine:
                        self.masculineButton.backgroundColor = self.feedbackColors[true]
                        self.masculineButton.backgroundColor = UIColor.whiteColor()
                    case .Feminine:
                        self.feminineButton.backgroundColor = self.feedbackColors[true]
                        self.feminineButton.backgroundColor = UIColor.whiteColor()
                    case .Neuter:
                        self.neuterButton.backgroundColor = self.feedbackColors[true]
                        self.neuterButton.backgroundColor = UIColor.whiteColor()
                    }
                    
                }
            },
            completion: { (bool: Bool) in
                self.currentWordLabel.alpha = 1
                self.enableButtons(true)
                self.updateView()
            })
    }
        
    func updateView() {
        if game.running {
            // update currentWord label
            currentWordLabel.text = game.currentWord?.word
            currentGenderLabel.text = game.currentWord!.language.genderName(game.currentWord!.gender)
            
            scoreLabel.text = "\(game.score)"
            remainingWordsLabel.text = "\(game.remainingWordsInRound)"
            remainingRoundsLabel.text = "\(game.currentRound + 1)/\(game.roundStack.count)"
            wordProgressBar.setProgress((Float(1.0) - Float(game.remainingWordsInRound) / Float(game.wordSource.count)), animated: true)
        } else {
            enableButtons(false)
            currentWordLabel.text = "gg wp"
        }
    }
    
    func enableButtons(enabled: Bool) {
        masculineButton.enabled = enabled
        feminineButton.enabled = enabled
        neuterButton.enabled = enabled
    }
    
    func updateTimeLabel() {
        timeRunningLabel.text = String(format: "%.1f", game.time())
    }
    
}
