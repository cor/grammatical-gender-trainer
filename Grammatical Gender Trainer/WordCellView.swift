//
//  WordCellView.swift
//  Grammatical Gender Trainer
//
//  Created by Cor Pruijs on 24-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import UIKit

class WordCellView : UITableViewCell {

    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    
    var word: Word! {
        didSet {
            genderLabel.text = word.language.genderName(word.gender)
            
            // set colors based on gender
            switch word.gender {
            case .Masculine:
                genderLabel.backgroundColor = UIColor(hex: 0x251191, alpha: 1)
                genderLabel.textColor = UIColor.whiteColor()
            case .Feminine:
                genderLabel.backgroundColor = UIColor(hex: 0xDD32AF, alpha: 1)
                genderLabel.textColor = UIColor.whiteColor()
            case .Neuter:
                genderLabel.backgroundColor = UIColor(hex: 0xE8E0C7, alpha: 1)
                genderLabel.textColor = UIColor.blackColor()
            }
            
            wordLabel.text = word.word
        }
    }
    
}
