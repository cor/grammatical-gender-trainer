//
//  WrtsParserDelegate.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 03-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

class WrtsParserDelegate : NSObject, NSXMLParserDelegate {
    var data = ""
    
    func parser(parser: NSXMLParser!,didStartElement elementName: String!, namespaceURI: String!, qualifiedName : String!, attributes attributeDict: NSDictionary!) {
        data = ""
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        data += string
    }
    
    func parser(parser: NSXMLParser!, parseErrorOccurred parseError: NSError!) {
        println("error \(parseError)")
    }
    
    func toLanguage(lang: String) -> Language! {
        switch data {
        case "Nederlands": return Language.Dutch
        case "Duits": return Language.German
        default: return nil
        }
    }
}