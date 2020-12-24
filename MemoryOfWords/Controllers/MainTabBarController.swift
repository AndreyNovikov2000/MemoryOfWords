//
//  MainTabBarController.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Private meethods
    
    private lazy var wordVC: WordsViewController = .loadFromStoryboard()
    private lazy var formattedWordVC = generateViewController(withRootViewController: wordVC,
                                                     navigationTitile: "Жаңа сөздер",
                                                     tabBarImage: UIImage(systemName: "rectangle.dock"))
    
    private lazy var comliteVC: ComplitedViewController = .loadFromStoryboard()
    private lazy var formattedComliteVC = generateViewController(withRootViewController: comliteVC,
                                                            navigationTitile: NSLocalizedString("Үйренген сөздер", comment: ""),
                                                            tabBarImage: UIImage(systemName: "person.crop.circle.fill"))
    
    private lazy var historyVC: HistoryViewController = .loadFromStoryboard()
    private lazy var formattedHistoryVC = generateViewController(withRootViewController: historyVC,
                                                            navigationTitile: NSLocalizedString("Қазақстан тарихы", comment: ""),
                                                            tabBarImage: UIImage(systemName: "doc.text"))

    
    private lazy var profileVC: ProfileViewController = .loadFromStoryboard()
    private lazy var profileViewController = generateViewController(withRootViewController: profileVC,
                                                            navigationTitile: NSLocalizedString("Профиль", comment: ""),
                                                            tabBarImage: UIImage(systemName: "person.circle"))
    
    // MARK: - Live cycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuteTabBar()
        setupControllers()
        
        view.backgroundColor = K.Colors.mainRed
    }
    
    // MARK: - Private methods
    
    private func configuteTabBar() {
        tabBar.tintColor = .systemBlue
        tabBar.isTranslucent = true
        tabBar.barTintColor = .white
        tabBar.tintColor = color1
        tabBar.unselectedItemTintColor = .gray
    }
    
    
    private func setupControllers() {
        
        viewControllers = [
            formattedComliteVC,
            formattedWordVC,
            formattedHistoryVC,
            profileViewController
        ]
    }
    
    private func generateViewController(withRootViewController rootViewController: UIViewController, navigationTitile: String, tabBarImage: UIImage?) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.navigationBar.barTintColor = UIColor(named: "background-navigation")
        navigationVC.tabBarItem.title = navigationTitile
        navigationVC.tabBarItem.image = tabBarImage
        rootViewController.navigationItem.title = navigationTitile
        return navigationVC
    }
}


