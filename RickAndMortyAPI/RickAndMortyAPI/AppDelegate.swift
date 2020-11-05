//
//  AppDelegate.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 13.10.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var navigationContoller: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        windowConfiguration()
        return true
    }
}

// MARK: - Window configuration

extension AppDelegate {
    private func windowConfiguration() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainVC = Assembly.createCharacterModule()
        navigationContoller = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = navigationContoller
        window?.makeKeyAndVisible()
    }
}

