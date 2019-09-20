//
//  PropertyWrappers.swift
//  WWDCPlayer
//
//  Created by Giftbot on 2019/09/15.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import Foundation

@propertyWrapper
class UserDefault<T> {
  private let key: String
  private let defaultValue: T
  
  init(key: String, defaultValue: T) {
    self.key = key
    self.defaultValue = defaultValue
  }
  
  var wrappedValue: T {
    get {
      UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
    }
    set {
      UserDefaults.standard.set(newValue, forKey: key)
    }
  }
}
