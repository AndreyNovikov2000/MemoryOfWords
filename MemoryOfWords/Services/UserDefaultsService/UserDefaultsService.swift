//
//  UserDefaultsService.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import Foundation

class UserDefaultsService {
    
    // MARK: - Instance properties
    
    static let shared = UserDefaultsService()
    
    let userKey = "user_key"
    let currentUserKey = "current_user_key"
    let learnedKey = "learned_key"
    let complitedKey = "complited_key"
    let loginKey = "login"
    let imageKey = "imageKey"
    
    // MARK: - Private propertoes
    
    private let defaults = UserDefaults.standard
    
    
    func add(user: User) {
        var users = getUsers()
        users.append(user)
        
        if let usersData = try? NSKeyedArchiver.archivedData(withRootObject: users, requiringSecureCoding: false) {
            defaults.set(usersData, forKey: userKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    func getUsers() -> [User] {
        var users = [User]()
        let data = defaults.value(forKey: userKey) as? Data ?? Data()
        
        if let usersData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [User] {
            users = usersData
        }
        
        users.forEach { (u) in
            print(u.userName, u.password)
        }
        
        return users
    }
    
    func getUser(_ user: User) -> User? {
        let users = getUsers()
        return users.first { (u) in
            return u.userName == user.userName && u.password == user.password
        }
    }
    
    func setCurrentUser(_ user: User) {
        if let userData = try? NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false) {
            defaults.set(userData, forKey: currentUserKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    func getCurrentUser() -> User? {
        if let data = defaults.value(forKey: currentUserKey) as? Data,
           let user = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? User {
            return user
        }
        
        return nil
    }
    
    func delete(word: Word, forKey key: String) {
        var words = getWords(forKey: key)
        if let index = words.firstIndex(where: { $0.newWord == word.newWord && $0.translate == word.translate }) {
            words.remove(at: index)
            saveWord(forKey: key, words: words)
        }
    }
    
    func addWord(word: Word, forKey key: String) {
        var words = getWords(forKey: key)
        words.append(word)
        saveWord(forKey: key, words: words)
        UserDefaults.standard.synchronize()
    }
    
    func getWords(forKey key: String) -> [Word] {
        var words = [Word]()
        let data = defaults.value(forKey: key) as? Data ?? Data()
        
        if let wordsWrapped = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Word] {
            words = wordsWrapped
        }
        
        return words
    }
    
    func saveWord(forKey key: String, words: [Word]) {
        if let data = try? NSKeyedArchiver.archivedData(withRootObject: words, requiringSecureCoding: false) {
            defaults.setValue(data, forKeyPath: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    func isLogin() -> Bool {
        return defaults.value(forKey: loginKey) as? Bool ?? false
    }
    
    func setLogin(_ value: Bool) {
        defaults.set(value, forKey: loginKey)
        UserDefaults.standard.synchronize()
    }
    
    func setImage(imageData: Data?) {
        guard let data = imageData else { return }
        defaults.set(data, forKey: imageKey)
        UserDefaults.standard.synchronize()
    }
    
    func getImageData() -> Data? {
        return defaults.value(forKey: imageKey) as? Data
    }
}
