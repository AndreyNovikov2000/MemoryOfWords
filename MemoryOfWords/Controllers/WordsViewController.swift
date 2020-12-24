//
//  WordsViewController.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import UIKit

class WordsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var wordCollectionView: UICollectionView!
    
    // MARK: - Private propeerties
    
    private var words = [Word]() {
        didSet {
            wordCollectionView.reloadData()
        }
    }
    
    private let defaults = UserDefaultsService.shared
    
    // MARK: - Object livecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        words = defaults.getWords(forKey: defaults.learnedKey)
            
        setupNavigationBar()
        setupNavigationButton()
        wordCollectionView.backgroundColor = .white
    }
    
    // MARK: - Selector methods
    
    @objc private func handleAddButtonTapped() {
        addNewWord()
       
    }
    
    //  MARK: - Private methods
    
    private func setupNavigationButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add,
                                     target: self,
                                     action: #selector(handleAddButtonTapped))
        button.tintColor = .black
        navigationItem.rightBarButtonItem = button
    }
    
    private func addNewWord() {
        let controller = UIAlertController(title: "Добавить новое слово",
                                           message: "",
                                           preferredStyle: .alert)
        
        controller.addTextField { textField in
            textField.placeholder = "Жаңа сөз"
        }
        
        controller.addTextField { textField in
            textField.placeholder = "Аудару"
        }
        
        let saveAction = UIAlertAction(title: "Сақтау", style: .default) { [weak self] alert in
            guard let self = self else { return }
            guard
                let firstTf = controller.textFields?.first, let mainTitle = firstTf.text,  mainTitle != "",
                let secondTf = controller.textFields?.last, let languageTitle = secondTf.text, languageTitle != ""
            else { return }
            
            let word = Word(newWord: mainTitle, translate: languageTitle)
            self.defaults.addWord(word: word, forKey: self.defaults.learnedKey)
            self.words.append(word)
            self.wordDidAddNotification()
        }
        
        let cancelAction = UIAlertAction(title: "Болдырмау", style: .destructive)
        
        controller.addAction(saveAction)
        controller.addAction(cancelAction)
        
        present(controller, animated: true)
    }
    
    private func setupNavigationBar() {
        let attribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: color1]
        navigationController?.navigationBar.titleTextAttributes = attribute
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func wordDidAddNotification() {
        NotificationCenter.default.post(name: .WordDidAdd, object: nil, userInfo: [:])
    }
}


// MARK: - UICollectionViewDataSource


extension WordsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WordCell.reuseId, for: indexPath) as! WordCell
        let word = words[indexPath.row]
        cell.configure(word)
        cell.myDelegate = self
        return cell
    }
}


// MARK: - UICollectionViewDelegate


extension WordsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? WordCell

        cell?.flip()
    }
}


// MARK: - UICollectionViewDataSource

extension WordsViewController: UICollectionViewDelegateFlowLayout {
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

extension WordsViewController: WordCellDelegate {
    func wordCellDidSaveTap(_ wordCell: WordCell) {
        guard let indexPath = wordCollectionView.indexPath(for: wordCell) else { return }
        let word = words[indexPath.row]
        var userInfo: [String: Word] = [:]
        userInfo["word"] = word
        
        
        NotificationCenter.default.post(name: .WordDidComplite,
                                        object: self,
                                        userInfo: userInfo)
        
        defaults.addWord(word: word, forKey: defaults.complitedKey)
        defaults.delete(word: word, forKey: defaults.learnedKey)
        words.remove(at: indexPath.row)
    }
}



