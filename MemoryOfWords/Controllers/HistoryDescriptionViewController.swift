//
//  HistoryDescriptionViewController.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import UIKit

class HistoryDescriptionViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var textView: UITextView!
    
    
    // MARK: - Instance properties
    
    var historyBody: History?
    
    // MARK: - Object live cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupNavigationBar()
        setupTextView()
    }
    
    // MARK: - Private methods
    
    private func setupNavigationBar() {
        navigationItem.title = historyBody?.title
        navigationItem.backButtonTitle = ""
        let attribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: color1]

        navigationController?.navigationBar.titleTextAttributes = attribute
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor(named: "background-navigation")
    }
    
    private func setupTextView() {
        textView.text = historyBody?.body
        textView.textContainerInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        textView.font = .systemFont(ofSize: 16)
    }
}
