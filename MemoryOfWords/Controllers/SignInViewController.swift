//
//  SignInViewController.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - Public properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Private properties
    
    private var textFieldIsShow = false
    private var user = User()
    
    // MARK: - UI
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "a.circle.fill")
        imageView.tintColor = K.Colors.buttonRedColor
        return imageView
    }()
    
    private let univerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign in"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let capsuleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = K.Colors.backgroundMainRed
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let loginView: LoginView = {
        let view = LoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loginTextField: AuthTextField = {
        let textField = AuthTextField(image: UIImage(systemName: "envelope.fill"),
                                      placeholder: "Логин",
                                      isSecure: false)
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: AuthTextField = {
        let textField = AuthTextField(image: UIImage(systemName: "eye.slash.fill"),
                                      placeholder: "Пароль",
                                      isSecure: true)
        textField.delegate = self
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSignInButtonTapped), for: .touchUpInside)
        button.makePretty(withTitle: "Кіру", backgroundC: K.Colors.buttonRedColor)
        return button
    }()
    
    // MARK: - Live cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginView()
        
        view.backgroundColor = K.Colors.mainRed
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardNotification()
    }
    
    // MARK: - Selector methods
    
    @objc private func handleSignInButtonTapped() {
        guard let userName = loginTextField.text, let password = passwordTextField.text else { return }
        user = User(userName: userName, password: password)
        UserDefaultsService.shared.add(user: user)
        UserDefaultsService.shared.setLogin(true)
        performSegue(withIdentifier: "id", sender: nil)
    }
    
    
    @objc private func handleKeyboardNotification(notification: Notification) {
        guard let keyboardRect = notification.userInfo?[UIWindow.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        guard let keyboardAnimationDuration = notification.userInfo?[UIWindow.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        
        let keyboardYPosition = view.frame.height - keyboardRect.height
        let logoViewHeight = loginView.frame.height + loginView.frame.origin.y
        let diffHeight = logoViewHeight - keyboardYPosition
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            UIView.animate(withDuration: keyboardAnimationDuration) {
                self.logoImageView.transform = .identity
            }
            
            self.view.frame.origin.y = 0
            textFieldIsShow = false
        }
        
        guard textFieldIsShow == false else { return }
        
        if notification.name == UIResponder.keyboardWillShowNotification && self.view.frame.origin.y == 0 {
            UIView.animate(withDuration: keyboardAnimationDuration) {
                self.logoImageView.transform = CGAffineTransform(translationX: 0, y: 75)
            }
            self.view.frame.origin.y -= diffHeight + 30
            textFieldIsShow = true
        }
    }
    
    // MARK: - Public methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textFieldIsShow = false
        view.resignFirstResponder()
    }
    
    
    // MARK: - Private methods
    
    private func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupLoginView() {
        view.addSubview(loginView)
        view.addSubview(univerLabel)
        view.addSubview(capsuleView)
        view.addSubview(logoImageView)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        // loginView
        loginView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // univerLabel
        univerLabel.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 70).isActive = true
        univerLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 16).isActive = true
        
        // capsuleView
        capsuleView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        capsuleView.topAnchor.constraint(equalTo: univerLabel.bottomAnchor, constant: 7).isActive = true
        capsuleView.leadingAnchor.constraint(equalTo: univerLabel.leadingAnchor, constant: -10).isActive = true
        capsuleView.trailingAnchor.constraint(equalTo: univerLabel.trailingAnchor, constant: 10).isActive = true
        
        // logoImageView
        logoImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: loginView.topAnchor, constant: -5).isActive = true
        
        // emailTextField
        loginTextField.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 16).isActive = true
        loginTextField.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -16).isActive = true
        loginTextField.topAnchor.constraint(equalTo: capsuleView.bottomAnchor, constant: 70).isActive = true
        
        // passwordTextField
        passwordTextField.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 16).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -16).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 60).isActive = true
        
        // loginButton
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 220).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: -35).isActive = true
    }
}



// MARK: - UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textFieldIsShow = false
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.resignFirstResponder()
    }
}

