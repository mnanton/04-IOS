//
//  SceneDelegate.swift
//  DBHeroes
//
//  Created by Miguel Nantón Díaz on 26/9/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
      // MARK: - Asignación Vista Inicial
        let window = UIWindow(windowScene: scene)
        let viewController = LoginViewController()
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
        self.window = window
        
    }
}

    

