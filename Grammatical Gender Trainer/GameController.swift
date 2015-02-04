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
        
        start()
    }
    
    func start() {
        currentRoundWords = words
        currentRoundWords.shuffle()
        nextRoundWords = [Word]()
        
        score = 0
        round = 1
        
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
        
        if (currentWord.gender == gender) {
            score++
        } else {
            nextRoundWords.append(currentWord)

            score--
        }
        
        nextWord()
        
        updateDisplay()
    }
    
    func updateDisplay() {
        roundLabel.text = "\(round)"
        scoreLabel.text = "\(score)"

        currentWordLabel.text = currentWord.word
    }
    
    func nextWord() {
        currentWordIndex++
        
        if (currentWordIndex == currentRoundWords.count) {
            nextRound()
        }
    }
    
    func nextRound() {
        if (nextRoundWords.isEmpty) {
            currentRoundWords = words
            
        } else {
            currentRoundWords = nextRoundWords
        }
        currentRoundWords.shuffle()
        currentWordIndex = 0
        nextRoundWords = [Word]()
        round++
    }
}