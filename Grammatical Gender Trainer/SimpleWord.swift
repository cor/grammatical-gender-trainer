//
//  WrtsWord.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 03-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

class SimpleWord : Word
{
    var word: String
    var gender: Gender
    var language: Language

    init(word: String, gender: Gender, language: Language) {
        self.word = word
        self.gender = gender
        self.language = language
    }
    
    var description : String { return "\(word) (\(gender))" }
}