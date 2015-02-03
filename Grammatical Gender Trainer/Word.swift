//
//  Word.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 02-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

protocol Word : Printable
{
    var word : String { get }
    var gender : Gender { get }
    var language : Language { get }
}