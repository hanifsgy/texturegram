//
//  GramModel.swift
//  Texturegram
//
//  Created by Hanif Sugiyanto on 22/03/19.
//  Copyright © 2019 Personal Organization. All rights reserved.
//

import Foundation

typealias GramModelResponses = [GramModel]

public struct GramModel: Codable {
  public let id: String
  public let createdAt: String
  public let updateAt: String
  public let width: Int
  public let height: Int
  public let color: String
  public let description: String?
  public let altDescription: String?
  public let urls: DataURL
  public let links: DataLinks
  public let likes: Int
  public let user: UserModel
  
  private enum CodingKeys: String, CodingKey {
    case id, width, height, color, description, urls, links, likes, user
    case createdAt = "created_at"
    case updateAt = "updated_at"
    case altDescription = "alt_description"
  }
}

public struct DataURL: Codable {
  public let raw: String?
  public let full: String?
  public let regular: String?
  public let small: String?
  public let thumb: String?
}

public struct DataLinks: Codable {
  public let api: String?
  public let html: String?
  public let download: String?
  public let downloadLoc: String
  
  private enum CodingKeys: String, CodingKey {
    case api = "self"
    case html, download
    case downloadLoc = "download_location"
  }
}
