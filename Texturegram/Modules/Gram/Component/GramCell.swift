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
  
  lazy var profileImageNode: ASNetworkImageNode = {
    let node = ASNetworkImageNode()
    node.clipsToBounds = true
    node.placeholderColor = Attributes.placeholderColor
    node.style.preferredSize = CGSize(width: 25.0, height: 25.0)
    node.cornerRadius = 12.5
    node.placeholderEnabled = true
    node.placeholderFadeDuration = 0.3
    return node
  }()
  
  lazy var usernameNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = 1
    node.placeholderColor = Attributes.placeholderColor
    node.placeholderEnabled = true
    node.placeholderFadeDuration = 0.3
    return node
  }()
  
  lazy var timesNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = 1
    node.placeholderColor = Attributes.placeholderColor
    node.placeholderEnabled = true
    node.placeholderFadeDuration = 0.3
    return node
  }()
  
  lazy var postNode: ASNetworkImageNode = {
    let node = ASNetworkImageNode()
    node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
    node.clipsToBounds = true
    node.placeholderColor = Attributes.placeholderColor
    node.placeholderEnabled = true
    node.placeholderFadeDuration = 0.3
    return node
  }()
  
  lazy var statusLikeNode: ASImageNode = {
    let node = ASImageNode()
    node.image = #imageLiteral(resourceName: "ic_favorite_48pt")
    node.style.preferredSize = CGSize(width: 20.0, height: 20.0)
    return node
  }()
  
  init(data: GramModel) {
    super.init()
    self.backgroundColor = .white
    self.automaticallyManagesSubnodes = true
    self.selectionStyle = .none
    
    self.postNode
      .setURL(URL(string: data.urls.full!),
              resetToDefault: true)
    
    self.postNode
      .placeholderColor = hexStringToUIColor(hex: data.color)
    
    self.usernameNode
      .attributedText = NSAttributedString(string: data.user.name ?? "")
    
    self.profileImageNode
      .setURL(URL(string: data.user.profileImage?.medium ?? "")!,
              resetToDefault: true)
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
                                            alignItems: .start,
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


extension GramCell {
  func hexStringToUIColor(hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
      return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
}
