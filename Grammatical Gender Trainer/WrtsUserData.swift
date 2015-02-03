//
//  WrtsGroupXml.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 02-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

class WrtsUserData
{
    let groups: [Group]
    let lists: [List]

    class ParserDelegate : WrtsParserDelegate {
        
        let connection: WrtsConnection
        
        init(connection: WrtsConnection) {
            self.connection = connection
        }
        class ListData {
            var url: String?
            var name: String?
            var language1: Language?
            var language2: Language?
        }
        
        class GroupData {
            var name : String?
            var childLists = [List]()
            var childGroups = [Group]()
        }
        
        enum State {
            case Other, Group, List
        }
        
        var currentState : State { return states.last! }
        var currentGroup : GroupData! { return groups.last }
        
        // List details
        var currentList : ListData?
        var groups = [ GroupData() ]
        var states = [State.Other]
        
        var url : String?
        var title : String?
        
        override func parser(parser: NSXMLParser!,didStartElement elementName: String!, namespaceURI: String!, qualifiedName : String!, attributes attributeDict: NSDictionary!) {

            super.parser(parser, didStartElement: elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributes: attributeDict)
            
            switch elementName {
            case "list":
                currentList = ListData()
                currentList!.url = attributeDict["href"] as? String
                
                states.append(.List)
            case "group":
                let newGroup = GroupData()
                
                groups.append(newGroup)
                
                states.append(.Group)
            default:
                break;
            }
        }
        
        func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
            switch(elementName) {
            case "lang-a": currentList?.language1 = toLanguage(data)
            case "lang-b": currentList?.language2 = toLanguage(data)
            case "title":
                switch currentState {
                case .List: currentList?.name = data
                case .Group: currentGroup?.name = data
                case .Other: assert(false, "Did not expect 'title' when state is 'Other'")
                }
            case "list":
                if currentList?.language1 == Language.German || currentList?.language2 == Language.German {
                    currentGroup.childLists.append(WrtsList(connection: self.connection, url: currentList!.url!, name: currentList!.name!))
                }
                
                currentList = nil
                states.removeLast()
            case "group":
                
                var newGroup = SimpleGroup(name: currentGroup.name!, lists: currentGroup.childLists, groups: currentGroup.childGroups)
                
                states.removeLast()
                groups.removeLast()

                if (!newGroup.groups.isEmpty || !newGroup.lists.isEmpty) {
                    currentGroup.childGroups.append(newGroup)
                }
            default: break
            }
            
            data = ""
        }
    }
    
    init(connection: WrtsConnection, url: String) {
        
        let parserDelegate = ParserDelegate(connection: connection);

        connection.parse(connection, url: url, delegate: parserDelegate)
        
        groups = parserDelegate.currentGroup.childGroups
        lists = parserDelegate.currentGroup.childLists
    }
}