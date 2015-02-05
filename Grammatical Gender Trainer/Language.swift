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
    
    var locale : NSLocale {
        switch self {
        case .German: return NSLocale(localeIdentifier: "de")
        case .Dutch: return NSLocale(localeIdentifier: "nl")
        }
    }
    
    var description: String {
        switch self {
        case .German: return "German"
        case .Dutch: return "Dutch"
        }
    }
    
    func genderName(gender: Gender) -> String {
        switch self {
        case .German:
            switch gender {
            case .Masculine: return "der"
            case .Feminine: return "die"
            case .Neuter: return "das"
            }
        default: return gender.description
        }
    }
}