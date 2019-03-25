//
//  AppContext.swift
//  Texturegram
//
//  Created by Hanif Sugiyanto on 22/03/19.
//  Copyright © 2019 Personal Organization. All rights reserved.
//

import Foundation

public class AppContext {
  
  init() {
    
  }
  
  public static var instance: AppContext {
    return AppContext()
  }
  
  public func infoForKey(_ key: String) -> String {
    return ((Bundle.main.infoDictionary?[key] as? String)?
      .replacingOccurrences(of: "\\", with: ""))!
  }
}
