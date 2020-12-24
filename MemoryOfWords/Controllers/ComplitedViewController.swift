//
//  ComplitedViewController.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import UIKit

class ComplitedViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Prrivate properties
    
    private var complitedWords = [Word]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let defaults = UserDefaultsService.shared

    
    // MARK: - Object live cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        complitedWords = defaults.getWords(forKey: defaults.complitedKey)
        
        setupListener()
        setupNavigationBar()
        collectionView.backgroundColor = .white
    }
    
    // MARK: - Private methods
    
    private func setupListener() {
        NotificationCenter.default.addObserver(forName: .WordDidComplite,
                                               object: nil,
                                               queue: nil) { [weak self] (notification) in
            guard let word = notification.userInfo?["word"] as? Word else { return }
            self?.complitedWords.append(word)
        }
    }
    
    private func setupNavigationBar() {
        let attribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: color1]

        navigationController?.navigationBar.titleTextAttributes = attribute
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor(named: "background-navigation")
    }
}


// MARK: - UICollectionViewDataSource


extension ComplitedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        complitedWords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WordCell.reuseId, for: indexPath) as! WordCell
        let word = complitedWords[indexPath.row]
        cell.configure(word, imageName: "trash.circle")
        cell.myDelegate = self
        return cell
    }
}


// MARK: - UICollectionViewDelegate


extension ComplitedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? WordCell

        cell?.flip()
    }
}


// MARK: - UICollectionViewDataSource

extension ComplitedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Sizes.width, height: Sizes.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 16, left: 16, bottom: 16, right: 16)
    }
}


// MARK: - WordCellDelegate

extension ComplitedViewController: WordCellDelegate {
    func wordCellDidSaveTap(_ wordCell: WordCell) {
        guard let indexPath = collectionView.indexPath(for: wordCell) else { return }
        let word = complitedWords[indexPath.row]
        complitedWords.remove(at: indexPath.row)
        defaults.delete(word: word, forKey: defaults.complitedKey)
        NotificationCenter.default.post(name: .WordDidRemove, object: self, userInfo: [:])
    }
}


