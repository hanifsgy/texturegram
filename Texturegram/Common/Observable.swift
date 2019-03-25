//
//  Observable.swift
//  Texturegram
//
//  Created by Hanif Sugiyanto on 23/03/19.
//  Copyright © 2019 Personal Organization. All rights reserved.
//

import RxSwift
import RxCocoa

extension ObservableType where E == Bool {
  public func not() -> Observable<Bool> {
    return self.map(!)
  }
  
}

extension SharedSequenceConvertibleType {
  func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
    return map { _ in }
  }
}

extension ObservableType {
  func catchErrorJustComplete() -> Observable<E> {
    return catchError { _ in
      return Observable.empty()
    }
  }
  
  func asDriverOnErrorJustComplete() -> Driver<E> {
    return asDriver { error in
      return Driver.empty()
    }
  }
  
  func mapToVoid() -> Observable<Void> {
    return map { _ in }
  }
}
