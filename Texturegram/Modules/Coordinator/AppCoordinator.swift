//
//  AppCoordinator.swift
//  Texturegram
//
//  Created by M Hanif Sugiyanto on 01/07/21.
//  Copyright © 2021 Personal Organization. All rights reserved.
//

import RxSwift
import AsyncDisplayKit

class AppCoordinator: BaseCoordinator<Void> {
  private let window: UIWindow
  init(window: UIWindow) {
    self.window = window
    self.window.backgroundColor = UIColor.white
  }
  override func start() -> Observable<CoordinationResult> {
    let homeCoordinator = HomeCoordinator(window: self.window)
    return self.coordinate(to: homeCoordinator)
  }
}

