//
//  AppDelegate.swift
//  Midia
//
//  Created by Oscar canton on 28/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let tabBarController = window?.rootViewController as? UITabBarController,
                let homeViewController = tabBarController.viewControllers?.first as? HomeViewController,
                let searchViewController = tabBarController.viewControllers?[1] as? SearchViewController,
                let favouriteViewController = tabBarController.viewControllers?[2] as? FavoritesViewController else {
            fatalError("Wrong initial setup")
        }
        
        let currentMediaItemProvider = MediaItemProvider(withMediaItemKind: .movie)

        homeViewController.mediaItemProvider = currentMediaItemProvider
        searchViewController.mediaItemProvider = currentMediaItemProvider
        favouriteViewController.mediaItemProvider = currentMediaItemProvider
        return true
    }
}

