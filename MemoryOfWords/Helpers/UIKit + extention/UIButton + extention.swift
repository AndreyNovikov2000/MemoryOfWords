//
//  UIButton + extention.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import UIKit

extension UIButton {
    func makePretty(withTitle title: String, backgroundC: UIColor) {
        setTitle(title, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 20)
        setTitleColor(.white, for: .normal)
        backgroundColor = backgroundC
        
        // shadows
        let shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowColor = shadowColor.cgColor
        layer.cornerRadius = 25
    }
}
