//
//  WordListController.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 03-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import UIKit

class WordListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var list: List!
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "cellIdentifier"
    let showQuizIdentifier = "showQuiz"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = list.name
    }

    // UITableViewDataSource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.words.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as UITableViewCell
        
        cell.textLabel?.text = list.words[indexPath.item].word
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        switch segue.destinationViewController {
        case let gameController as GameController:

            gameController.gameTitle = list.name
            gameController.words = list.words
        default: break
        }
    }
}