//
//  AppDelegate.swift
//  ProgressExample
//
//  Created by Kaira Diagne on 06/01/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = ImageDownloadViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
