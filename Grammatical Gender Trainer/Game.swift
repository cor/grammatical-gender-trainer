//
//  Game.swift
//  Grammatical Gender Trainer
//
//  Created by Cor Pruijs on 05-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

class Game {
    
    // MARK: - Stat Properties
    var currentRound = 0
    var currentWord: Word? = nil
    var score = 0
    var running = true
    
    var startTime : NSDate?
    var endTime : NSDate?
    
    var remainingWords: Int {
        return roundStack[currentRound].remainingWords
    }
    
    // MARK: - Data Properties
    let wordSource: [Word]
    var roundStack: [GameRound]
    
    // MARK: - Initializers
    init(words: [Word]) {
        wordSource = words
        roundStack = []
    }
    
    // MARK: - Controll Methods
    func start() {
        
        running = true
        roundStack = []
        
        roundStack.append(GameRound(wordStack: wordSource.shuffled()))
        
        startTime = NSDate()
        endTime = nil
        
        nextWord()
    }
    
    func end() {
        if running {
            running = false
            endTime = NSDate()
        }
    }
    
    private func nextWord() {
        
        if let word = roundStack[currentRound].nextWord() {
            currentWord = word
        } else {
            end()
            // TODO: Go to the next round
        }
        
    }
    
    func answer(answer: Gender) {
        if currentWord != nil {
            
            // check if the answer is correct
            if answer == currentWord!.gender {
                score++
                nextWord()
            } else {
                
                // create a new GameRound if ther isn't a next round available
                if !(roundStack.count == currentRound + 2) {
                    roundStack.append(GameRound())
                }
                
                // add the incorrect word to the next round
                roundStack[currentRound + 1].addWord(currentWord!)
                score--
                nextWord()
            }
            
        }
    }
    
    // TODO: this method
    func time() -> Double {
        if let startTime = startTime {
            if let endTime = endTime {
                return endTime.timeIntervalSinceDate(startTime)
            } else {
                return NSDate().timeIntervalSinceDate(startTime)
            }
        } else {
            return 0.0
        }
    }
    
}