//
//  HistoryCell.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import UIKit

class HistoryCell: UITableViewCell {

    // MARK: - Instance properties
    
    static let reuseId = "HistoryCell"
    
    // MARK: - UI
    
    private let bubleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    
    // MARK: - Object livecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupCell()
        setupConstraints()
    }

    // MARK: - Public methods
    
    func configure(_ history: History) {
        titleLabel.text = history.title
    }
    
    // MARK: - Private methods
    
    private func setupCell() {
        backgroundColor = .white
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
    
    private func setupConstraints() {
        addSubview(bubleView)
        
        bubleView.addSubview(titleLabel)
        
        // bubleView
        NSLayoutConstraint.activate([
            bubleView.topAnchor.constraint(equalTo: topAnchor),
            bubleView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bubleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bubleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: bubleView.topAnchor, constant: 7),
            titleLabel.bottomAnchor.constraint(equalTo: bubleView.bottomAnchor, constant: -7),
            titleLabel.leadingAnchor.constraint(equalTo: bubleView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: bubleView.trailingAnchor)
        ])
    }
}
