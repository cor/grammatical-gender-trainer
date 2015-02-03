//
//  ViewController.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 02-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let source: Source = WrtsSource(user: "wrts@pruijs.nl", password: "uBq-eS8-nKs-d8p")
    
    @IBOutlet weak var data: UITextView!
    
    override func viewDidLoad() {
        var text = ""
        
        text += "\(source.description)\n"
        text += "\(source.root.description)\n"

        for list in source.root.lists {
            text += "\(list)\n"
            
            for word in list.words {
                text += "\(word)\n"
            }
        }
        
        data.text = text
    }
}

