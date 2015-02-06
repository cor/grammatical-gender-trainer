//
//  GameRound.swift
//  Grammatical Gender Trainer
//
//  Created by Cor Pruijs on 06-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

class GameRound: Printable {
    
    // MARK - properties
    private var wordStack: [Word]
    var remainingWords: Int {
        return wordStack.count
    }
    
    // MARK: - Public Methods
    func nextWord() -> Word? {
        if wordStack.count > 0 {
            return wordStack.removeLast()
        } else {
            // the stack is empty
            return nil
        }
    }
    
    func addWord(word: Word) {
        wordStack.append(word)
    }
    
    // MARK: - Initializers
    init() {
        wordStack = []
    }
    
    init(wordStack: [Word]) {
        self.wordStack = wordStack
    }

    var description : String {
    
        var result: String = ""
        var count = 0
        for word in wordStack {
            count++
            result = result + ("\(count)\t\(word.language.genderName(word.gender)) \(word.word)\n")
        }
        
        return result
    }
    
}