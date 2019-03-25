//
//  BaseResponse.swift
//  Texturegram
//
//  Created by Hanif Sugiyanto on 23/03/19.
//  Copyright © 2019 Personal Organization. All rights reserved.
//

import Foundation

public struct BaseResponses<T: Codable>: Codable {
  public let data: [T]
}

public struct BaseResponse<T: Codable>: Codable {
  public let data: T
}
