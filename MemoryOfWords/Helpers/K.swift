//
//  K.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import UIKit

let color1 = UIColor(r: 47, g: 160, b: 235)
let color = UIColor(r: 129, g: 217, b: 252)

struct K {
    struct UserDefaultsKeys {
        static let mainVC = "mainVC"
        static let cultureKey = "culture"
        static let login = "login"
        static let password = "password"
    }
    
    struct Colors {
        static let background = UIColor(named: "Background") ?? .white
        static let backgroundRed = UIColor(named: "BackgroundRed") ?? .white
        static let backroundGray = UIColor(named: "BackroundGray") ?? .white
        static let backgroundMainRed = UIColor(r: 210, g: 50, b: 45)//UIColor(named: "BackgroundRed") ?? .white
        static let mainRed = UIColor(r: 182, g: 11, b: 67)
        static let buttonRedColor =  UIColor(r: 47, g: 160, b: 235)//UIColor(r: 218, g: 0, b: 0)
    }
    
    struct AuthColors {
        // 47, 160, 235
        static let red = UIColor(r: 47, g: 160, b: 235)
        static let systemRed = UIColor(r: 220, g: 52, b: 86)
        static let white: UIColor = .white
    }
    
    struct ProfileModule {
        
    }
    
    struct FeedModule {
        // fonts
        static let postTextFont = UIFont.systemFont(ofSize: 16)
        static let titleTextFont = UIFont.boldSystemFont(ofSize: 17)
        
        // insets
        static let cardInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        static let titleTextInsents = UIEdgeInsets(top: 12, left: 16, bottom: 8, right: 16)
        static let postViewInsets = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        static let attachmentInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // reveal post
        static let minifiedPostLimitLines: CGFloat = 10
        static let minifiedPostLimit: CGFloat = 7
        
        // button size
        static let showMoreButtonSize = CGSize(width: 170, height: 30)
        static let moreButtonInsets: UIEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 0)
    }
}
