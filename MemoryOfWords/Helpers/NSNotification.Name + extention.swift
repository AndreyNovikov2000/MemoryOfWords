//
//  NSNotification.Name + extention.swift
//  MemoryOfWords
//
//  Created by AlemTome.
//

import Foundation

extension NSNotification.Name {
    static let WordDidAdd = Notification.Name.init("com.word.did.add")
    static let WordDidComplite = Notification.Name.init("com.word.did.complite")
    static let WordDidRemove = Notification.Name.init("com.word.did.remove")
}
