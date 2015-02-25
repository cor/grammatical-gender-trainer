//
//  GameController.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 04-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import UIKit

class PreGameController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var words : [Word]!
    var gameTitle : String!
    private var state = State.Initial
    private var game : Game!
    
    enum State {
        case Initial, Game, Result
    }
    
    @IBOutlet weak var splashView: UIView!
    
    
    // MARK: Stat label outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var currentWordLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // Mark: Button outlets
    @IBOutlet weak var masculineButton: UIButton!
    @IBOutlet weak var feminineButton: UIButton!
    @IBOutlet weak var neuterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = Game(words: words)
        title = gameTitle
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.destinationViewController {
        case let gameController as GameController:
            gameController.words = words
            gameController.game = game
        default: break;
        }
        
    }
    
    // MARK: TableView methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.wordSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("WordCell") as WordCellView
        cell.word = game.wordSource[indexPath.row]
        
        return cell
    }
    
}