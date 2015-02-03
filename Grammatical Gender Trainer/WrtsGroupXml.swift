//
//  WrtsGroupXml.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 02-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

class WrtsGroupXml
{
    let name : String
    let listUrls : [String]
    let groupUrls : [String]
    
    init(url : String) {
        // load stuff
        
        name = "Test"
        listUrls = [ "list1", "list2"]
        groupUrls = [ "group1", "group2"]
    }
}