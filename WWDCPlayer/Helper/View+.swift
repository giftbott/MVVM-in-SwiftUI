//
//  View+.swift
//  WWDCPlayer
//
//  Created by Giftbot on 2022/05/15.
//  Copyright © 2021 Giftbot. All rights reserved.
//

import SwiftUI

extension View {
  @ViewBuilder
  func showIf(_ shouldShow: Bool) -> some View {
    if shouldShow {
      self
    }
  }
}
