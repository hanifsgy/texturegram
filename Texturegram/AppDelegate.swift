//
//  AppDelegate.swift
//  Texturegram
//
//  Created by Hanif Sugiyanto on 18/03/19.
//  Copyright © 2019 Personal Organization. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  private let disposeBag: DisposeBag = DisposeBag()
  private var appCoordinator: AppCoordinator!
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    window = UIWindow(frame: UIScreen.main.bounds)
    if let window = window {
      appCoordinator = AppCoordinator(window: window)
      appCoordinator.start()
        .subscribe()
        .disposed(by: disposeBag)
    }
    return true
  }
}

