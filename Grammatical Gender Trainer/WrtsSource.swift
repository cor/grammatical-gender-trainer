//
//  WrtsSource.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 02-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

class WrtsSource : Source
{
    var user : String     // wrts@pruijs.nl
    var password : String // uBq-eS8-nKs-d8p
    let url = "http://www.wrts.nl/api"
    
    init(user: String, password: String) {
        self.user = user
        self.password = password
    }
    
    var root : Group {
        get {
            return WrtsGroup(url: url)
        }
    }
    
    var description : String {
        return "Wrts of \(user)"
    }
}