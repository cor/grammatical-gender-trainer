
//
//  WrtsGroup.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 02-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

class WrtsGroup : Group
{
    let url : String
    var xml : WrtsGroupXml { return WrtsGroupXml(url: url) }

    init(url : String) {
        self.url = url
    }

    var name : String { return xml.name }
    
    var lists : [List] { return xml.listUrls.map() { WrtsList(url: $0) } }
    
    var groups : [Group] { return [Group]() }
    
    var description : String { return "Group \(url)" }
}