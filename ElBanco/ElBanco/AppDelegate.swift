//
//  AppDelegate.swift
//  ElBanco
//
//  Created by Sreekanth on 30/9/21.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController: UINavigationController?

    // MARK: AppDelegate launch event

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.setupHomeViewController(launchOptions)
        return true
    }

  
    // MARK: Setup Splash Scereen
    private func setupHomeViewController(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            if let window = window {
                let mainVC =  SplashViewController()
                navigationController = UINavigationController(rootViewController: mainVC)
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
            }
    }



}


