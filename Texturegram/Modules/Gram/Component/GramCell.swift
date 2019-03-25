//
//  GramCell.swift
//  Texturegram
//
//  Created by Hanif Sugiyanto on 18/03/19.
//  Copyright © 2019 Personal Organization. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import RxSwift
import RxCocoa

class GramCell: ASCellNode {
  
  struct Attributes {
    static let placeholderColor: UIColor = UIColor.gray.withAlphaComponent(0.8)
  }
  
  lazy var profileImageNode: ASImageNode = {
    let node = ASImageNode()
    node.clipsToBounds = true
    node.image = #imageLiteral(resourceName: "ic_profil")
    node.placeholderColor = Attributes.placeholderColor
    node.style.preferredSize = CGSize(width: 25.0, height: 25.0)
    node.cornerRadius = 12.5
    return node
  }()
  
  lazy var usernameNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = 1
    node.placeholderColor = Attributes.placeholderColor
    node.attributedText = NSAttributedString(string: "Omaewa mou sindeirou")
    return node
  }()
  
  lazy var timesNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = 1
    node.placeholderColor = Attributes.placeholderColor
    node.attributedText = NSAttributedString(string: "16w")
    return node
  }()
  
  lazy var postNode: ASNetworkImageNode = {
    let node = ASNetworkImageNode()
    node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
    node.clipsToBounds = true
    node.placeholderColor = Attributes.placeholderColor
    return node
  }()
  
  lazy var statusLikeNode: ASButtonNode = {
    let node = ASButtonNode()
    node.setImage(#imageLiteral(resourceName: "ic_profil"), for: .normal)
    node.setTitle("1.234 likes", with: UIFont.systemFont(ofSize: 12, weight: .medium), with: UIColor.darkGray, for: .normal)
    return node
  }()
  
  init(data: GramModel) {
    super.init()
    self.backgroundColor = .white
    self.automaticallyManagesSubnodes = true
    self.selectionStyle = .none
    
    self.postNode
      .setURL(URL(string: data.urls.regular!),
              resetToDefault: true)
    
    self.usernameNode
      .attributedText = NSAttributedString(string: data.user.name ?? "")
    
  }
  
}

extension GramCell {
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    profileImageNode.style.flexShrink = 1.0
    profileImageNode.style.flexGrow = 0.0
    usernameNode.style.flexShrink = 1.0
    usernameNode.style.flexGrow = 1.0
    let headerStackSpec = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 10.0,
                                            justifyContent: .center,
                                            alignItems: .notSet,
                                            children: [profileImageNode, usernameNode, timesNode])
    
    let contentStack = ASStackLayoutSpec(direction: .vertical,
                                         spacing: 5.0,
                                         justifyContent: .center,
                                         alignItems: .start,
                                         children: [headerStackSpec, postNode, statusLikeNode])
    contentStack.style.flexGrow = 1.0
    contentStack.style.flexShrink = 1.0
    return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10.0,
                                                  left: 10.0,
                                                  bottom: 10.0,
                                                  right: 10.0),
                             child: contentStack)
  }
  
}
