//
//  UnsplashAPI.swift
//  Texturegram
//
//  Created by Hanif Sugiyanto on 22/03/19.
//  Copyright © 2019 Personal Organization. All rights reserved.
//

import Moya

public enum UnsplashAPI {
  
  case getRandomPhotos
  
}

extension UnsplashAPI: TargetType {
  
  public var headers: [String : String]? {
    return [
      "Content-Type"  : "application/json",
      "Accept"        : "application/json"
    ]
  }
  
  public var baseURL: URL {
    return URL(string: "https://api.unsplash.com")!
  }
  
  public var path: String {
    switch self {
    case .getRandomPhotos:
      return "/photos/"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .getRandomPhotos:
      return .get
    }
  }
  
  public var sampleData: Data {
    return Data()
  }
  
  public var parameters: [String: Any]? {
    switch self {
    case .getRandomPhotos:
      return [
        "client_id": AppContext.instance.infoForKey("CLIENT_ID")
      ]
    }
  }
  
  public var parameterEncoding: ParameterEncoding {
    
    switch self.method {
    case .post, .put:
      return JSONEncoding.default
    default:
      return URLEncoding.default
    }
  }
  
  public var task: Task {
    switch self {
    default:
      return .requestParameters(parameters: parameters ?? [:], encoding: parameterEncoding)
    }
  }
  
}
