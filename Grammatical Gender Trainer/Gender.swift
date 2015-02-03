//
//  Gender.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 02-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

enum Gender : Printable
{
    case Masculine, Feminine, Neuter
    
    var name : String { return description }
    
    var description : String {
        switch self {
        case .Masculine: return "M"
        case .Feminine: return "F"
        case .Neuter: return "N"
        }
    }
}