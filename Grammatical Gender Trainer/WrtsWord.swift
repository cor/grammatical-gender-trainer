//
//  WrtsWord.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 03-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

class WrtsWord : Word
{
    var text: String
    var gender: Gender
    var language: Language

    init(text: String, gender: Gender, language: Language) {
        self.text = text
        self.gender = gender
        self.language = language
    }
    
    var description : String { return "\(text) (\(language))" }
}