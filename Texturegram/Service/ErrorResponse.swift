//
//  ErrorResponse.swift
//  Texturegram
//
//  Created by Hanif Sugiyanto on 22/03/19.
//  Copyright © 2019 Personal Organization. All rights reserved.
//

import Foundation

public struct ErrorResponse: Codable {
  public var error: Error
  
  public struct Error: Codable {
    public var errors: [String]
  }
}
