//
//  ProfileViewController.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let imagePickerController = UIImagePickerController()
    private var profileImage: UIImage?
    private let defaultCellId = String(describing: UITableViewCell.self)
    
    private lazy var addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        if let imageData = UserDefaultsService.shared.getImageData() {
            let image = UIImage(data: imageData)
            button.setImage(image, for: .normal)
            button.layer.cornerRadius = 70
            button.layer.borderWidth = 3
            button.layer.borderColor = color1.cgColor
            
            if button.imageView?.backgroundColor == .white {
                print("hello")
            }
        } else {
            button.setImage(UIImage(named: "plus_photo"), for: .normal)
        }
        
        button.tintColor = .clear
        button.addTarget(self, action: #selector(handleAddButtonPressed), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellId)
        tableView.register(SettingsLogoutCell.self, forCellReuseIdentifier: SettingsLogoutCell.reuseId)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        return tableView
    }()
    
    enum CellType: Int, CaseIterable {
        case defaultCell
        case outCell
    }
    
    private let storage = UserDefaultsService.shared
    private let source: [CellType] = [.defaultCell, .outCell]

    // MARK: - Object livecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setupConstraintsForAddPhotoButton()
        setupConstraintsForTableView()
        setupNavigationBar()
        
        view.backgroundColor = .white
        
        
        NotificationCenter.default.addObserver(forName: .WordDidComplite,
                                               object: nil,
                                               queue: nil) { [weak self] _ in
            guard let self = self else { return }
            self.update()
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: .WordDidRemove, object: nil, queue: nil) { [weak self] _ in
            guard let self = self else { return }
            self.update()
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: .WordDidAdd, object: nil, queue: nil) { [weak self] _ in
            guard let self = self else { return }
            self.update()
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Selector methods
    
    @objc private func handleAddButtonPressed() {
        present(imagePickerController, animated: true, completion: nil)
        imagePickerController.sourceType = .photoLibrary
    }
    
    // MARK: - Private methods
    
    private func setupConstraintsForAddPhotoButton() {
        view.addSubview(addPhotoButton)
        
        addPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        addPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
    }
    
    private func setupConstraintsForTableView() {
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func configureUI() {
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
    }
    
    @discardableResult
    private func update() -> String {
        let learnedCount = "\(storage.getWords(forKey: storage.learnedKey).count)"
        let complitedCont = "\(storage.getWords(forKey: storage.complitedKey).count)"
        let allCount = "\((Int(learnedCount) ?? 0) + (Int(complitedCont) ?? 0))"
        return  complitedCont + " / " + allCount + " сөз үйренді"
    }
    
    private func setupNavigationBar() {
        let attribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: color1]

        navigationController?.navigationBar.titleTextAttributes = attribute
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor(named: "background-navigation")
    }
}


// MARK: -  UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageData = image.jpegData(compressionQuality: 0.5)
        self.profileImage = image
        
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.height / 2
        addPhotoButton.layer.borderWidth = 3
        addPhotoButton.layer.borderColor = color1.cgColor
        
        addPhotoButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        UserDefaultsService.shared.setImage(imageData: imageData)
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let value = source[indexPath.row]
        
        switch value {
        case .defaultCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellId, for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.text = update()
            return cell
        case .outCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsLogoutCell.reuseId, for: indexPath) as! SettingsLogoutCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let value = source[indexPath.row]
        
        switch value {
        case .defaultCell:
            return 60
        case .outCell:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value = source[indexPath.row]
        
        switch value {
        case .defaultCell:
           break
        case .outCell:
            let loginVC: LoginViewController = .loadFromStoryboard()
            UserDefaultsService.shared.setLogin(false)
            UIApplication.shared.windows.first?.rootViewController = loginVC
        }
    }
}
