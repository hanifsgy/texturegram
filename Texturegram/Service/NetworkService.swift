//
//  NetworkService.swift
//  Texturegram
//
//  Created by Hanif Sugiyanto on 22/03/19.
//  Copyright © 2019 Personal Organization. All rights reserved.
//

import Moya
import RxSwift

public struct NetworkService {
  
  public static let instance = NetworkService()
  fileprivate let provider: MoyaProvider<MultiTarget>
  
  private init() {
    self.provider = MoyaProvider<MultiTarget>(
      plugins: [
        RequestLoadingPlugin()
      ]
    )
  }
}

public extension NetworkService {
  
  func requestObject<T: TargetType, C: Decodable>(_ t: T, c: C.Type) -> Single<C> {
    return provider.rx.request(MultiTarget(t))
      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .filterSuccessfulStatusAndRedirectCodes()
      .map(c.self)
      .catchError({ (error) in
        guard let errorResponse = error as? MoyaError else { return Single.error(NetworkError.IncorrectDataReturned) }
        switch errorResponse {
        case .underlying(let (e, _)):
          print(e.localizedDescription)
          return Single.error(NetworkError(error: e as NSError))
        default:
          let body = try errorResponse.response?.map(ErrorResponse.self)
          if let body = body {
            return Single.error(NetworkError.SoftError(message: body.error.errors.first))
          } else {
            return Single.error(NetworkError.IncorrectDataReturned)
          }
        }
      })
    
  }
  
}
