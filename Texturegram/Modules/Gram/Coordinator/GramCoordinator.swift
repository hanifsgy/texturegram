//
//  GramCoordinator.swift
//  Texturegram
//
//  Created by M Hanif Sugiyanto on 01/07/21.
//  Copyright © 2021 Personal Organization. All rights reserved.
//

import RxSwift
import AsyncDisplayKit

class GramCoordinator: BaseCoordinator<Void> {
  private let navigationController: ASNavigationController
  
  init(navigationController: ASNavigationController) {
    self.navigationController = navigationController
  }
  
  override func start() -> Observable<Void> {
    let nodeGramViewModel = GramViewModel()
    let nodeGramController = GramController(viewModel: nodeGramViewModel)
    navigationController.setViewControllers([nodeGramController], animated: true)
    return Observable.empty()
  }
}
