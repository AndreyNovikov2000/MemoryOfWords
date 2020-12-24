//
//  SceneDelegate.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let defaultService = UserDefaultsService()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.frame = UIScreen.main.bounds
        setInitionalVC()
        window?.makeKeyAndVisible()
    }
    
    private func setInitionalVC() {
        if !defaultService.isLogin() {
            let loginVC: LoginViewController = .loadFromStoryboard()
            window?.rootViewController = loginVC
        } else {
            let tabBarController: MainTabBarController = .loadFromStoryboard()
            window?.rootViewController = tabBarController
        }
    }
}

