//
//  WrtsListXml.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 03-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

class WrtsListXml
{
    let name : String
    let words : [Word]
    
    class ParserDelegate : WrtsParserDelegate {
        var words = [Word]()
        var title : String?
        
        var language_a : Language?
        var language_b : Language?
        
        var name : String?
        var listUrls = [String]()
        var groupUrls = [String]()
        
        func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
            switch(elementName) {
            case "lang-a": language_a = toLanguage(data)
            case "lang-b": language_b = toLanguage(data)
            case "word-a": processWordData(data, language: language_a)
            case "word-b": processWordData(data, language: language_b)
            default: break
            }
        }
        
        func processWordData(data: String, language: Language?) {
            if let lang = language {
                processWordData(data, language: lang)
            }
            
        }
        
        func processWordData(data: String, language: Language) {
            if let (word, gender) = split(data, language: language) {
                words.append(SimpleWord(word: word, gender: gender, language: language))
            }
        }
        
        func split(data: String, language: Language) -> (String, Gender)? {
            switch language {
            case .German:
                let parts = data.componentsSeparatedByString(" ")
                if (parts.count >= 2) {
                    let firstPart = parts[0].uppercaseStringWithLocale(language.locale)
                    let wordParts = " ".join(parts[1..<parts.count])
                    switch firstPart {
                    case "DER": return (wordParts, Gender.Masculine)
                    case "DIE": return (wordParts, Gender.Feminine)
                    case "DAS": return (wordParts, Gender.Neuter)
                    default: return nil
                    }
                } else {
                    return nil
                }
            default: return nil
            }
        }
    }
   
    init(connection: WrtsConnection, url: String) {
        let parserDelegate = ParserDelegate();

        connection.parse(connection, url: url, delegate: parserDelegate)
        
        // load stuff
        
        if (parserDelegate.title == nil) {
            name = "Unknown"
        } else {
            name = parserDelegate.title!
        }

        words = parserDelegate.words
    }
}