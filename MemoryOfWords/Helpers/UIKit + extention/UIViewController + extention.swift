//
//  UIViewController + extention.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import UIKit


extension UIViewController {
    func alert(title: String, message: String, complition: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            complition?()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func alert(title: String, message: String, actionTitle: String, complition:@escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: .destructive) { (_) in
            complition()
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .default)
        
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    static func loadFromStoryboard<T: UIViewController>() -> T {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: String(describing: T.self)) as? T else {
            fatalError()
        }
        
        return viewController
    }
}
