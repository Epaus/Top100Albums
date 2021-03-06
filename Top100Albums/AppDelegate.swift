//
//  AppDelegate.swift
//  Top100Albums
//
//  Created by Estelle Paus on 6/18/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var networkManager = NetworkManager()
    var navigationController: UINavigationController?
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
       
        let mainController = MainViewController(frame:CGRect.zero, networkManager: networkManager)
       
        navigationController = UINavigationController.init(rootViewController: mainController)
        
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
                   let navBarAppearance = UINavigationBarAppearance()
                   navBarAppearance.configureWithOpaqueBackground()
                   navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                   navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                   navBarAppearance.backgroundColor = .systemRed
                   navigationController?.navigationBar.standardAppearance = navBarAppearance
                   navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
               }
        
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

