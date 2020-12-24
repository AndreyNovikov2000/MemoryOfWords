//
//  Word.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import Foundation

class Word: NSObject, NSCoding {
    var newWord: String
    var translate: String
    
    override init() {
        newWord = ""
        translate = ""
    }
    
    init(newWord: String, translate: String) {
        self.newWord = newWord
        self.translate = translate
    }
    
    required init?(coder: NSCoder) {
        newWord = coder.decodeObject(forKey: "newWord") as? String ?? ""
        translate = coder.decodeObject(forKey: "translate") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(newWord, forKey: "newWord")
        coder.encode(translate, forKey: "translate")
    }
}
