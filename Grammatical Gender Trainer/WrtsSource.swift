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
    let connection : WrtsConnection
    
    init(username: String, password: String) {
        connection = WrtsConnection(username: username, password: password)
    }
    
    var root : Group {
        get {
            let source = WrtsUserData(connection: connection, url: "http://www.wrts.nl/api/lists")
            
            return SimpleGroup(name:"root", lists: source.lists, groups: source.groups)
        }
    }
    
    var description : String {
        return "Wrts of \(connection.username)"
    }
}