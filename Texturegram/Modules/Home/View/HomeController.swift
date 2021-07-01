//
//  HomeController.swift
//  Texturegram
//
//  Created by M Hanif Sugiyanto on 01/07/21.
//  Copyright © 2021 Personal Organization. All rights reserved.
//

import AsyncDisplayKit
import RxCocoa
import RxSwift

class HomeController: ASTabBarController {
  
}

enum GramKind: Int {
  case search
  case add
  case notif
  
  var icon: UIImage? {
    switch self {
    case .search:
      return self.getImage(name: "magnifyingglass")
    case .add:
      return self.getImage(name: "plus")
    case .notif:
      return self.getImage(name: "bell")
    }
  }
  var selectedIcon: UIImage? {
    switch self {
    case .search:
      return self.getImage(name: "magnifyingglass")
    case .add:
      return self.getImage(name: "plus")
    case .notif:
      return self.getImage(name: "bell")
    }
  }
  var navigationController: ASNavigationController {
      let n = ASNavigationController()
      n.tabBarItem.image = self.icon
      n.tabBarItem.selectedImage = self.selectedIcon
      return n
  }
  
  func getImage(name: String) -> UIImage? {
    if #available(iOS 13.0, *) {
      return UIImage(systemName: name)
    } else {
      return nil
    }
  }
}
