//
//  WrtsListXml.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 03-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

class WrtsListXml
{
    let name : String
    let words : [Word]
    
    init(url : String) {
        // load stuff
        
        name = "Test List"
        words = [
            WrtsWord(text: "Woord 1", gender: Gender.Feminine, language: Language.Dutch),
            WrtsWord(text: "Wurde 1", gender: Gender.Feminine, language: Language.German) ]
    }
}