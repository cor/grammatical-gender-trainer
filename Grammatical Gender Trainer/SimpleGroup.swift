
//
//  WrtsGroup.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 02-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

class SimpleGroup : Group
{
    var name : String
    var lists : [List]
    var groups : [Group]
    
    init(name: String, lists: [List], groups: [Group]) {
        self.name = name
        self.lists = lists
        self.groups = groups
    }

    var description : String { return "Group \(name)" }
}