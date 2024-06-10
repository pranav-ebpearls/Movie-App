//
//  AppDelegate.swift
//  Movie-App
//
//  Created by ebpearls on 6/4/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {  
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let tabbar = UITabBarController()
        let mainVC = UINavigationController(rootViewController: MainViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        
        mainVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"),selectedImage: UIImage(systemName: "house.fill"))
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"),selectedImage: UIImage(systemName: "person.fill"))
        
        tabbar.viewControllers = [mainVC, profileVC]
        window.rootViewController = tabbar
        window.makeKeyAndVisible()
        
        self.window = window
        return true
    }

}

