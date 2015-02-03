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
    let url : String
    var xml : WrtsListXml { return WrtsListXml(url: url) }
    
    var name : String { return xml.name }
    var words : [Word] { return xml.words }

    
    init(url : String) {
        self.url = url
    }
    
    var description : String { return "\(url)" }
}