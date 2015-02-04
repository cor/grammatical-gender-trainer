//
//  GameController.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 04-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import UIKit

extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}

class GameController: UIViewController
{
    var words : [Word]!
    var gameTitle : String!
    var currentWordIndex = 0
    var score = 0
    var round = 1
    var state = State.Initial
    
    @IBOutlet weak var splashView: UIView!

    enum State {
        case Initial, Game, Result
    }
    
    var currentRoundWords : [Word] = [Word]()
    var nextRoundWords : [Word] = [Word]()
    
    var currentWord : Word {
        return currentRoundWords[currentWordIndex]
    }

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
        
        title = gameTitle
        
        updateDisplay()
    }
    
    @IBAction func masculine() {
        select(Gender.Masculine)
    }
    
    @IBAction func feminine() {
        select(Gender.Feminine)
    }

    @IBAction func neuter() {
        select(Gender.Neuter)
    }
    
    func select(gender: Gender) {
        if (state == .Game) {
            if (currentWord.gender == gender) {
                score++
            } else {
                nextRoundWords.append(currentWord)

                score--
            }
            
            nextWord()
            
            updateDisplay()
        }
    }
    
    @IBAction func start() {
        state = .Game
        
        score = 0
        round = 1

        initRound(words)

        updateDisplay()
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
        case .Game:
            
            currentWordLabel.text = currentWord.word
            
            masculineButton.setTitle(currentWord.language.genderName(Gender.Masculine), forState: UIControlState.Normal)
            feminineButton.setTitle(currentWord.language.genderName(Gender.Feminine), forState: UIControlState.Normal)
            neuterButton.setTitle(currentWord.language.genderName(Gender.Neuter), forState: UIControlState.Normal)

            roundLabel.hidden = false
            timeLabel.hidden = false
            scoreLabel.hidden = false
            splashView.hidden = true
            masculineButton.enabled = true
            feminineButton.enabled = true
            neuterButton.enabled = true
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
        }
        
        roundLabel.text = "\(round)"
        scoreLabel.text = "\(score)"
    }
    
    func nextWord() {
        currentWordIndex++
        
        if (currentWordIndex == currentRoundWords.count) {
            nextRound()
        }
    }
    
    func nextRound() {
        if (nextRoundWords.isEmpty) {
            state = .Result
        } else {
            round++

            initRound(nextRoundWords)
        }
    }
    
    func initRound(roundWords: [Word]) {
        currentRoundWords = roundWords
        currentRoundWords.shuffle()
        
        currentWordIndex = 0
        nextRoundWords = [Word]()
    }
}