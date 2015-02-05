//
//  Game.swift
//  Grammatical Gender Trainer
//
//  Created by Cor Pruijs on 05-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation


// array extension that returns an shuffled copy of an array,
// this will be used to randomize the word order
extension Array {
    func shuffled() -> [T] {
        var list = self
        for i in 0..<(list.count - 1) {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
}

class Game {
    
    var currentRound = 0
    var currentWord: Word? = nil
    var score = 0
    
    let wordSource: [Word]
    var wordStacks: [[Word]] = [[Word]]()
    
    var startTime : NSDate?
    var endTime : NSDate?
    
    var remainingWords: Int {
        return wordStacks[currentRound].count
    }
    
    init(words: [Word]) {
        wordSource = words
        wordStacks.append(wordSource.shuffled())
        
        nextWord()
    }
    
    private func nextWord() -> Word? {
        
        if wordStacks[currentRound].count > 0 {
            currentWord = wordStacks[currentRound].removeLast()
            return currentWord!
        } else {
            println("ERROR: no new word available")
            return nil
        }
    }
    
    func answer(answer: Gender) {
        if currentWord != nil {
            
            // check if the answer is correct
            if answer == currentWord!.gender {
                score++
                nextWord()
            }
            
        } else {
            // TODO: add word to new stack
            score--
        }
    }
    
    
    // WIP method
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