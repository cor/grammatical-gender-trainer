//
//  GameController.swift
//  Grammatical Gender Trainer
//
//  Created by Cor Pruijs on 24-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    @IBOutlet weak var currentWordLabel: UILabel!
    @IBOutlet weak var wordProgressBar: UIProgressView!
    
    var words: [Word]!
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game(words: words)
        game.start()
        updateView()
    }
    
    @IBAction func genderButtonPressed(sender: UIButton) {
        
        // use the button's Restoration ID to get the Gender and use the Game model's answer function
        if let identifier = sender.restorationIdentifier {
            switch identifier {
            case "Masculine": game.answer(Gender.Masculine)
            case "Feminine": game.answer(Gender.Feminine)
            case "Neuter": game.answer(Gender.Neuter)
            default: println("ERROR: invalid Restoration Identifier")
            }
        }
        
        updateView()
        
    }
        
    func updateView() {
        if game.currentWord != nil {
            // update currentWord label
            currentWordLabel.text = game.currentWord?.word
            
            wordProgressBar.setProgress((Float(1.0) - Float(game.remainingWordsInRound) / Float(game.wordSource.count)), animated: true)
            
        }
        
    }
    
    
}
