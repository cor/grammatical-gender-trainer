//
//  Group.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 02-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

protocol Group : Printable
{
    var name : String { get }
    var lists : [List] { get }
    var groups : [Group] { get }
}