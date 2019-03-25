//
//  AppDelegate.swift
//  Texturegram
//
//  Created by Hanif Sugiyanto on 18/03/19.
//  Copyright © 2019 Personal Organization. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    window = UIWindow(frame: UIScreen.main.bounds)
    let viewModel = GramViewModel()
    let rootVC = GramController(viewModel: viewModel)
    let navController = UINavigationController(rootViewController: rootVC)
    if let window = window {
      window.rootViewController = navController
      window.makeKeyAndVisible()
    }
    return true
  }
}

