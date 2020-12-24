//
//  AuthTextField.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import UIKit


class AuthTextField: UITextField {
    
    // MARK: - Init
    
    convenience init(image: UIImage?, placeholder: String, isSecure: Bool) {
        self.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        isSecureTextEntry = isSecure
        textColor = .white
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)
        ])
        
        setupLeftView(withImage: image)
        setupDivider()
    }
    
    
    // MARK: - Publuc methods
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x -= 3
        return rect
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 27, dy: 0)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 27, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 27, dy: 0)
    }
    
    // MARK: - Private methods
    
    
    private func setupLeftView(withImage image: UIImage?) {
        let leftImageView = UIImageView(image: image)
        leftImageView.tintColor = K.Colors.buttonRedColor
        leftView = leftImageView
        leftView?.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        leftViewMode = .always
    }
    
    private func setupDivider() {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .white
        divider.alpha = 0.5
        divider.layer.cornerRadius = 0.3
        
        addSubview(divider)
        
        NSLayoutConstraint.activate([
            divider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 3),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}
