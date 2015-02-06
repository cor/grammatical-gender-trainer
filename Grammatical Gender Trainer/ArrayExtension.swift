//
//  ShuffledArrayExtension.swift
//  Grammatical Gender Trainer
//
//  Created by Cor Pruijs on 06-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

// array extension that returns an shuffled copy of an array,
// this will be used to randomize the word order
extension Array {
    func shuffled() -> [T] {
        var list = self
        for i in 0..<(list.count - 1) {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
}