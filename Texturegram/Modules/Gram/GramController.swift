//
//  GramController.swift
//  Texturegram
//
//  Created by Hanif Sugiyanto on 18/03/19.
//  Copyright © 2019 Personal Organization. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import RxCocoa
import RxSwift

class GramController: ASViewController<ASTableNode>{
  
  /// Context
  private var context: ASBatchContext?
  /// viewModel
  private var viewModel: GramViewModel!
  private let disposeBag: DisposeBag = DisposeBag()
  
  init(viewModel: GramViewModel) {
    self.viewModel = viewModel
    
    let tableNode = ASTableNode(style: .plain)
    tableNode.backgroundColor = .white
    tableNode.automaticallyManagesSubnodes = true
    super.init(node: tableNode)
    
    self.title = "TextureGram"
    
    self.node.onDidLoad { (node) in
      guard let `node` = node as? ASTableNode else { return }
      node.view.separatorColor = .none
    }
    
    self.node.leadingScreensForBatching = 2.0
    self.node.dataSource = self
    self.node.delegate = self
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.input.refreshI.onNext("")
    
    viewModel.output.refreshO
      .do(onNext: { [weak self] (_) in
        guard let `self` = self else { return }
        self.node.reloadData()
        self.context?.completeBatchFetching(true)
        self.context = nil
      })
      .drive()
      .disposed(by: disposeBag)
  }
  
  
}


extension GramController: ASTableDelegate {
  func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
    return self.context == nil
  }
  func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
    self.context = context
  }
}

extension GramController: ASTableDataSource {
  func numberOfSections(in tableNode: ASTableNode) -> Int {
    return 1
  }
  func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.output.itemsO.value.count
  }
  func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
    return {
      guard self.viewModel.output.itemsO.value.count > indexPath.row else { return ASCellNode() }
      let data = self.viewModel.output.itemsO.value[indexPath.row]
      let cellNode = GramCell(data: data)
      return cellNode
    }
  }
}
