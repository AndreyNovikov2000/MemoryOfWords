//
//  SettingsCell.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import UIKit

class SettingsLogoutCell: UITableViewCell {
    
    static let reuseId = "SettingsCell"
    
    // MARK: - UI
    
    private let bubleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color1
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints =  false
        label.font = .boldSystemFont(ofSize: 21)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Шығу"
        return label
    }()
    
    // MARK: - Live cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private methods
    
    private func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        
    }
    
    private func setupConstraints() {
        addSubview(bubleView)
        bubleView.addSubview(titleLabel)
        
        // bubleView
        NSLayoutConstraint.activate([
            bubleView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            bubleView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bubleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bubleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: bubleView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: bubleView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: bubleView.trailingAnchor, constant: -20)
        ])
    }
}
