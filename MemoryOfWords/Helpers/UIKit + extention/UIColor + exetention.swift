//
//  UIColor + exetention.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import UIKit

extension UIColor {
    static let mainOrange = UIColor(red: 1, green: 0.5620236723, blue: 0, alpha: 1)
    static let backgroundBlue = UIColor(red: 0.0003317313676, green: 0.4764195085, blue: 0.9903067946, alpha: 1)
    static let backgroundWhite = UIColor(red: 0.9492354989, green: 0.9486114383, blue: 0.9704449773, alpha: 1)
    static let backgroundRed = UIColor(red: 0.9652878642, green: 0.2853717804, blue: 0.4039801359, alpha: 1)
    static let mainBlue = UIColor(red: 0.3490949869, green: 0.442735225, blue: 1, alpha: 1)
    static let backgroundGray =  UIColor(red: 0.631372549, green: 0.6470588235, blue: 0.662745098, alpha: 1)
    
    
}


extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
}
