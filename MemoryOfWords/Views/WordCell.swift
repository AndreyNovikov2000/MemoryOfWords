//
//  WordCell.swift
//  MemoryOfWords
//
//  Created by AlenTime.
//

import UIKit

protocol WordCellDelegate: class {
    func wordCellDidSaveTap(_ wordCell: WordCell)
}

class WordCell: UICollectionViewCell {
    
    // MARK: - Instance proprties
    
    weak var myDelegate: WordCellDelegate?
    static let reuseId = "WordCell"
    
    // MARK: - UI
    
    let backBubleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = color1
        view.isHidden = true
        return view
    }()
    
    let backLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var backSaveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let frontBubleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = color1
        return view
    }()
    
    let frontLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var frontSaveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
        button.imageView?.tintColor = .white
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    
    // MARK: - Object live cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = .clear
        setupConstraints()
    }
    
    // MARK: - Selector methods
    
    @objc private func handleSaveButton() {
        myDelegate?.wordCellDidSaveTap(self)
    }
    
    
    // MARK: - Configure
    
    func configure(_ word: Word, imageName: String? = nil) {
        frontLabel.text = word.newWord
        backLabel.text = word.translate
        
        if let imageName = imageName {
            backSaveButton.setImage(UIImage(systemName: imageName), for: .normal)
            frontSaveButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    // MARK: - Animation
    
    func flip() {
        let flipSide: UIView.AnimationOptions = frontBubleView.isHidden ? .transitionFlipFromRight : .transitionFlipFromLeft
        let animationView: UIView = frontBubleView.isHidden ? frontBubleView : backBubleView
            UIView.transition(with: animationView, duration: 0.3, options: flipSide, animations: { [weak self] in
                self?.frontBubleView.isHidden = !(self?.frontBubleView.isHidden ?? true)
                self?.backBubleView.isHidden = !(self?.backBubleView.isHidden ?? false)
            }, completion: nil)
        }
 
    // MARK: - Private methods
    
    private func setupConstraints() {
        addSubview(backBubleView)
        addSubview(frontBubleView)
        
        backBubleView.addSubview(backLabel)
        backBubleView.addSubview(backSaveButton)
        
        frontBubleView.addSubview(frontLabel)
        frontBubleView.addSubview(frontSaveButton)
        
        
        // backBubleView
        NSLayoutConstraint.activate([
            backBubleView.topAnchor.constraint(equalTo: topAnchor),
            backBubleView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backBubleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backBubleView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        // backLabel
        NSLayoutConstraint.activate([
            backLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            backLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            backLabel.widthAnchor.constraint(equalToConstant: Sizes.width - 32),
            backLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // backSaveButton
        NSLayoutConstraint.activate([
            backSaveButton.heightAnchor.constraint(equalToConstant: 50),
            backSaveButton.widthAnchor.constraint(equalToConstant: 50),
            backSaveButton.bottomAnchor.constraint(equalTo: backBubleView.bottomAnchor, constant: -5),
            backSaveButton.trailingAnchor.constraint(equalTo: backBubleView.trailingAnchor, constant: 5)
        ])
        
        // frontBubleView
        NSLayoutConstraint.activate([
            frontBubleView.topAnchor.constraint(equalTo: topAnchor),
            frontBubleView.bottomAnchor.constraint(equalTo: bottomAnchor),
            frontBubleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            frontBubleView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        // backLabel
        NSLayoutConstraint.activate([
            frontLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            frontLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            frontLabel.widthAnchor.constraint(equalToConstant: Sizes.width - 32),
            frontLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // backSaveButton
        NSLayoutConstraint.activate([
            frontSaveButton.heightAnchor.constraint(equalToConstant: 50),
            frontSaveButton.widthAnchor.constraint(equalToConstant: 50),
            frontSaveButton.bottomAnchor.constraint(equalTo: frontBubleView.bottomAnchor, constant: -5),
            frontSaveButton.trailingAnchor.constraint(equalTo: frontBubleView.trailingAnchor, constant: 5)
        ])
    }
}
