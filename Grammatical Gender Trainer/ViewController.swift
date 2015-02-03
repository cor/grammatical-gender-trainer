//
//  ViewController.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 02-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    let source: Source = WrtsSource(username: "wrts@pruijs.nl", password: "uBq-eS8-nKs-d8p")
    let source: Source = WrtsSource(username: "qlpc@q8p.nl", password: "School5ucks4Lyfe")
    
    
    @IBOutlet weak var data: UITextView!
    
    override func viewDidLoad() {
        var text = ""
        
        text += "\(source.description)\n"

        text += printGroup(source.root, indent: "")
        
        data.text = text
    }
    
    func printList(list: List, indent: String) -> String {
        var text = ""
        text += "\(indent)List '\(list.name):'\n"
        
//        for word in list.words {
//            text += "  \(indent)\(word)\n"
//        }
        
        return text
    }
    
    func printGroup(group : Group, indent: String) -> String {
        var text = ""
        text += "\(indent)\(group.name):\n"
        
        for list in group.lists {
            text += "\(indent)" + printList(list, indent: indent + "  ")
        }
        
        for group in group.groups {
            text += "\(indent)Group: " + printGroup(group, indent: indent + "  ")
        }
        
        return text
    }
}

