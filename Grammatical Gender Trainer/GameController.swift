//
//  GameController.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 04-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    var words : [Word]!
    var gameTitle : String!
    var state = State.Initial
    
    var game : Game!
    
    enum State {
        case Initial, Game, Result
    }
    
    
    @IBOutlet weak var splashView: UIView!

    @IBOutlet weak var wordsLabel: UILabel!
    
    // Score
    @IBOutlet weak var scoreLabel: UILabel!
    
    // Word
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var currentWordLabel: UILabel!

    // Buttons
    @IBOutlet weak var masculineButton: UIButton!
    @IBOutlet weak var feminineButton: UIButton!
    @IBOutlet weak var neuterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = Game(words: words)
        title = gameTitle
        
        updateDisplay()
    }
    
    // MARK: Input
    
    @IBAction func genderButtonPressed(sender: UIButton) {
        
        if let identifier = sender.restorationIdentifier {
            switch identifier {
            case "Masculine": game.answer(Gender.Masculine)
            case "Feminine": game.answer(Gender.Feminine)
            case "Neuter": game.answer(Gender.Neuter)
            default: println("ERROR: invalid Restoration Identifier")
            }
            
            updateDisplay()
        }
    }
    
    @IBAction func startButtonPressed() {
        
        state = .Game
        game.start()
        
        updateDisplay()
        
        // update the timer label 10 times per second second
        NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector: Selector("updateTimeLabel"), userInfo: nil, repeats: true)
        
        
    }
    
    func updateDisplay() {
        switch state {
        case .Initial:
            
            currentWordLabel.text = ""
            
            masculineButton.setTitle("", forState: UIControlState.Normal)
            feminineButton.setTitle("", forState: UIControlState.Normal)
            neuterButton.setTitle("", forState: UIControlState.Normal)

            roundLabel.hidden = true
            timeLabel.hidden = true
            scoreLabel.hidden = true
            splashView.hidden = false
            masculineButton.enabled = false
            feminineButton.enabled = false
            neuterButton.enabled = false
            
            wordsLabel.text = words.description
            
            
        case .Game:
            
            
            if game.currentWord != nil {
                
                // update currentWord label
                currentWordLabel.text = game.currentWord?.word
                
                // update answer buttons
                masculineButton.setTitle(game.currentWord!.language.genderName(Gender.Masculine), forState: UIControlState.Normal)
                feminineButton.setTitle(game.currentWord!.language.genderName(Gender.Feminine), forState: UIControlState.Normal)
                neuterButton.setTitle(game.currentWord!.language.genderName(Gender.Neuter), forState: UIControlState.Normal)
            }

            // hide and show UI elements because we're now In Game
            roundLabel.hidden = false
            timeLabel.hidden = false
            scoreLabel.hidden = false
            splashView.hidden = true
            masculineButton.enabled = true
            feminineButton.enabled = true
            neuterButton.enabled = true
            
            wordsLabel.text = ""
            
            
        case .Result:
            currentWordLabel.text = ""
            
            masculineButton.setTitle("", forState: UIControlState.Normal)
            feminineButton.setTitle("", forState: UIControlState.Normal)
            neuterButton.setTitle("", forState: UIControlState.Normal)

            roundLabel.hidden = false
            timeLabel.hidden = false
            scoreLabel.hidden = false
            splashView.hidden = false
            masculineButton.enabled = false
            feminineButton.enabled = false
            neuterButton.enabled = false
            
            wordsLabel.text = words.description
        }
        
        roundLabel.text = "\(42)"
        scoreLabel.text = "\(game.score)"
    }
    
    func updateTimeLabel() {
        timeLabel.text = String(format: timeFormat(), game.time())
    }
    
    func timeFormat() -> String {
        switch state {
        case .Result: return "%.2f"
        default: return "%.1f"
        }
    }
    
    
}