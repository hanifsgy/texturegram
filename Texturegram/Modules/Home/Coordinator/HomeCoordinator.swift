//
//  HomeCoordinator.swift
//  Texturegram
//
//  Created by M Hanif Sugiyanto on 01/07/21.
//  Copyright © 2021 Personal Organization. All rights reserved.
//

import RxSwift
import RxCocoa
import AsyncDisplayKit

class HomeCoordinator: BaseCoordinator<Void> {
  private let window: UIWindow
  private let viewNodeController: [ASNavigationController]
  var selectedIndex: Int = .zero
  
  init(window: UIWindow) {
    self.window = window
    self.viewNodeController = GramKind.items
      .map({ (items) -> ASNavigationController in
        let navigation = ASNavigationController()
        navigation.tabBarItem.image = items.icon
        return navigation
      })
  }
  
  override func start() -> Observable<CoordinationResult> {
    let homeController = HomeController()
    homeController.tabBar.backgroundColor = UIColor.white
    homeController.tabBar.isTranslucent = false
    homeController.viewControllers = viewNodeController
    let coordinates = viewNodeController.enumerated()
      .map { (offset, element) -> Observable<Void> in
        guard let items = GramKind(rawValue: offset) else { return Observable.just(())}
        switch items {
        case .search:
          return coordinate(to: GramCoordinator(navigationController: element))
        case .add:
          return coordinate(to: GramCoordinator(navigationController: element))
        case .notif:
          return coordinate(to: GramCoordinator(navigationController: element))
        }
      }
    Observable.merge(coordinates)
      .subscribe()
      .disposed(by: disposeBag)
    window.rootViewController = homeController
    window.makeKeyAndVisible()
    return Observable.never()
  }
}
