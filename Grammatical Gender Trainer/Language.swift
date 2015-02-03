//
//  Language.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 02-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

enum Language : Printable
{
    case German, Dutch
    
    var name : String { return description }
    
    var genders : [Gender] {
        switch self {
        case .German: return [Gender.Masculine, Gender.Feminine, Gender.Neuter]
        case .Dutch: return [Gender.Masculine, Gender.Feminine, Gender.Neuter]
        }
    }
    
    var description: String {
        switch self {
        case .German: return "German"
        case .Dutch: return "Dutch"
        }
    }
}