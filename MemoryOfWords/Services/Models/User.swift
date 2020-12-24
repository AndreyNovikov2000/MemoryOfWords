//
//  User.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import Foundation

class User: NSObject, NSCoding {
    var userName: String
    var password: String
    
    override init() {
        userName = ""
        password = ""
    }
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(userName, forKey: "userName")
        coder.encode(password, forKey: "password")
    }
    
    required init?(coder: NSCoder) {
        userName = coder.decodeObject(forKey: "userName") as? String ?? ""
        password = coder.decodeObject(forKey: "password") as? String ?? ""
    }
}


