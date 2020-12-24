//
//  HistoryViewController.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import UIKit

class HistoryViewController: UIViewController {

    // MARK: - IBAction
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    // MARK: - Private properties
    
    var history: [History] = History.getDescription() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var filtredHistory: [History] = []
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltring: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    // MARK: - Private properties
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    
    // MARK: - Object live cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSearchController()
        
        navigationItem.title = "Тарих"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        tableView.backgroundColor = .white
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let historyDescriptionVC = segue.destination as? HistoryDescriptionViewController, let indexPath = tableView.indexPathForSelectedRow {
            historyDescriptionVC.historyBody = history[indexPath.row]
        }
    }
    
    // MARK: - Selector methods
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = .zero
    }
    
    
    // MARK: - Private methods
    
    private func setupNavigationBar() {
        let attribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: color1]

        navigationController?.navigationBar.titleTextAttributes = attribute
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor(named: "background-navigation")
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = ""
        searchController.searchBar.setValue("болдырмау", forKey: "cancelButtonText")
        navigationItem.searchController = searchController
    }
}


// MARK: - UITableViewDataSource

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltring ? filtredHistory.count : history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.reuseId, for: indexPath) as! HistoryCell
        let currentHistory = isFiltring ? filtredHistory : history
        let currentItem = currentHistory[indexPath.row]
       
        cell.configure(currentItem)
        
        return cell
    }
}


// MARK: - UITableViewDelegate

extension HistoryViewController: UITableViewDelegate {
    
}


// MARK: -

extension HistoryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        filtredHistory = history.filter { history in
            return history.title.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
}
