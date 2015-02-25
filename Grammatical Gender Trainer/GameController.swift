//
//  GameController.swift
//  Grammatical Gender Trainer
//
//  Created by Cor Pruijs on 24-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    @IBOutlet weak var remainingWordsLabel: UILabel!
    @IBOutlet weak var remainingRoundsLabel: UILabel!
    @IBOutlet weak var timeRunningLabel: UILabel!
    @IBOutlet weak var currentWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var wordProgressBar: UIProgressView!
    @IBOutlet weak var currentWordView: UIView!
    
    let feedbackColors: [Bool: UIColor] = [true: UIColor.greenColor(), false: UIColor.redColor()]
    let feedbackTimes: [Bool: NSTimeInterval] = [true: NSTimeInterval(0.5), false: NSTimeInterval(2)]
    
    var words: [Word]!
    var game: Game!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        game = Game(words: words)
        game.start()
        updateView()
        
        NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector: Selector("updateTimeLabel"), userInfo: nil, repeats: true)
    }
    
    @IBAction func genderButtonPressed(sender: UIButton) {
        
        // use the button's Restoration ID to get the Gender and use the Game model's answer function
        if let identifier = sender.restorationIdentifier {
            
            var result: Bool?
            
            switch identifier {
            case "Masculine": result = game.answer(Gender.Masculine)
            case "Feminine": result = game.answer(Gender.Feminine)
            case "Neuter": result = game.answer(Gender.Neuter)
            default: println("ERROR: invalid Restoration Identifier")
            }
           
            if let result2 = result {
                giveFeedback(result2)
            }
        }
        
        
    }
    
    func giveFeedback(correct: Bool) {
        
        UIView.animateWithDuration(feedbackTimes[correct]!, animations: {
                self.currentWordView.backgroundColor = self.feedbackColors[correct]
                self.currentWordView.backgroundColor = UIColor.whiteColor()
            },
            completion: { (bool: Bool) in
                self.updateView()
            })
    }
        
    func updateView() {
        if game.running {
            // update currentWord label
            currentWordLabel.text = game.currentWord?.word
            
            scoreLabel.text = "\(game.score)"
            remainingWordsLabel.text = "\(game.remainingWordsInRound)"
            remainingRoundsLabel.text = "\(game.currentRound + 1)/\(game.roundStack.count)"
            wordProgressBar.setProgress((Float(1.0) - Float(game.remainingWordsInRound) / Float(game.wordSource.count)), animated: true)
            
        }
    }
    
    func updateTimeLabel() {
        timeRunningLabel.text = String(format: "%.1f", game.time())
    }
    
    
}
