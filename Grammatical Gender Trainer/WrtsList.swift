//
//  WrtsList.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 03-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

class WrtsList : List
{
    let connection : WrtsConnection
    let url : String
    var xml : WrtsListXml { return WrtsListXml(connection: connection, url: url) }
    let name : String
    
    var words : [Word] { return xml.words }
    
    init(connection: WrtsConnection, url: String, name: String) {
        self.connection = connection
        self.url = url
        self.name = name
    }
    
    var description : String { return "\(url)" }
}