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
    private var state = State.Initial
    private var game : Game!
    
    enum State {
        case Initial, Game, Result
    }
    
    
    @IBOutlet weak var splashView: UIView!
    
    // MARK: Stat label outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var currentWordLabel: UILabel!
    

    // Mark: Button outlets
    @IBOutlet weak var masculineButton: UIButton!
    @IBOutlet weak var feminineButton: UIButton!
    @IBOutlet weak var neuterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = Game(words: words)
        title = gameTitle
        
        setupWordsView()
        updateDisplay()
        
    }
    
    func setupWordsView() {
        
        
        // fonts for the attributed string
        let regularFont = UIFont(name: "Helvetica", size: 18.0)
        let boldFont = UIFont(name: "Helvetica-Bold", size: 18.0)
        
    }
    
    
    // MARK: Input
    @IBAction func genderButtonPressed(sender: UIButton) {
        
        // use the button's Restoration ID to get the Gender and use the Game model's answer function
        if let identifier = sender.restorationIdentifier {
            switch identifier {
            case "Masculine": game.answer(Gender.Masculine)
            case "Feminine": game.answer(Gender.Feminine)
            case "Neuter": game.answer(Gender.Neuter)
            default: println("ERROR: invalid Restoration Identifier")
            }
            
            // this should be replaced by a delegate
            if game.running == false {
                state = .Result
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
    
    
    // MARK: Update methods
    func updateDisplay() {
        
        switch state {
        case .Initial:
            
            hideGenderButtons(true)
            hideStatLabels(true)
            
            currentWordLabel.hidden = true
            splashView.hidden = false
            
        case .Game:
            
            if game.currentWord != nil {
                
                // update currentWord label
                currentWordLabel.text = game.currentWord?.word
                
                // update answer buttons
                masculineButton.setTitle(game.currentWord!.language.genderName(Gender.Masculine), forState: UIControlState.Normal)
                feminineButton.setTitle(game.currentWord!.language.genderName(Gender.Feminine), forState: UIControlState.Normal)
                neuterButton.setTitle(game.currentWord!.language.genderName(Gender.Neuter), forState: UIControlState.Normal)
            }

            hideGenderButtons(false)
            hideStatLabels(false)
            
            currentWordLabel.hidden = false
            splashView.hidden = true
            
        case .Result:
            
            hideStatLabels(false)
            hideGenderButtons(true)
            
            currentWordLabel.hidden = true
            splashView.hidden = false
        }
        
        roundLabel.text = "\(game.currentRound)"
        scoreLabel.text = "\(game.score)"
    }
    
    // MARK: Hide/show functions
    func hideGenderButtons(hidden: Bool) {
        masculineButton.hidden = hidden
        feminineButton.hidden = hidden
        neuterButton.hidden = hidden
    }
    
    func hideStatLabels(hidden: Bool) {
        roundLabel.hidden = hidden
        timeLabel.hidden = hidden
        scoreLabel.hidden = hidden
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