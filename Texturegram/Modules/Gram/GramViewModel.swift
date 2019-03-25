//
//  GramViewModel.swift
//  Texturegram
//
//  Created by Hanif Sugiyanto on 22/03/19.
//  Copyright © 2019 Personal Organization. All rights reserved.
//

import RxSwift
import RxCocoa

final class GramViewModel: ViewModelType {
  
  var input: Input
  var output: Output!
  
  struct Input {
    let refreshI: AnyObserver<String>
  }
  
  struct Output {
    let itemsO: BehaviorRelay<[GramModel]>
    let refreshO: Driver<Void>
  }
  
  private let refreshSubject = PublishSubject<String>()
  private let items = BehaviorRelay<[GramModel]>(value: [])
  
  private let activityIndicator = ActivityIndicator()
  private let errorTracker = ErrorTracker()
  
  init() {
    
    input = Input(
      refreshI: refreshSubject.asObserver()
    )
    
    /// Fetch data
    let items = refreshSubject.startWith("")
      .flatMapLatest { (_) -> Observable<[GramModel]> in
        return NetworkService.instance
          .requestObject(UnsplashAPI.getPhotos(page: 1, perPage: 30, orderBy: .latest),
                         c: GramModelResponses.self)
          .do(onSuccess: { [weak self] (model) in
            guard let `self` = self else { return }
            self.items.accept(model)
            }, onError: { (e) in
              print(e.localizedDescription)
          })
          .trackActivity(self.activityIndicator)
          .trackError(self.errorTracker)
          .asObservable()
      }
      .mapToVoid()
      .asDriverOnErrorJustComplete()
    
    
    output = Output(itemsO: self.items, refreshO: items)
    
  }
  
}
