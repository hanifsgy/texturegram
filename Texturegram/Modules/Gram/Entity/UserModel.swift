//
//  UserModel.swift
//  Texturegram
//
//  Created by Hanif Sugiyanto on 25/03/19.
//  Copyright © 2019 Personal Organization. All rights reserved.
//

import Foundation

public struct UserModel: Codable {
  
  public let id: String
  public let updatedAt: String?
  public let username: String?
  public let name: String?
  public let firstName: String?
  public let lastName: String?
  public let twitterUsername: String?
  public let portofolioUrl: String?
  public let bio: String?
  public let location: String?
  public let profileImage: ProfileImage?
  public let instagramUsername: String?
  public let totalCollection: Int
  public let totalLikes: Int
  public let totalPhotos: Int
  
  
  private enum CodingKeys: String, CodingKey {
    case id, username, name, bio, location
    case updatedAt = "updated_at"
    case firstName = "first_name"
    case lastName = "last_name"
    case twitterUsername = "twitter_username"
    case portofolioUrl = "portfolio_url"
    case profileImage = "profile_image"
    case instagramUsername = "instagram_username"
    case totalCollection = "total_collections"
    case totalLikes = "total_likes"
    case totalPhotos = "total_photos"
  }
  
}

public struct ProfileImage: Codable {
  public let small: String?
  public let medium: String?
  public let large: String?
}
