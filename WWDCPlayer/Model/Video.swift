//
//  Video.swift
//  WWDCPlayer
//
//  Created by Giftbot on 2019/09/13.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import Foundation

struct Video: Identifiable {
  var id: Int { sessionID }

  let sessionID: Int
  let title: String
  let duration: Int
  let weekDay: WeekDay
  let platforms: [Platform]
  let urlString: String
  var isFavorite = false
}

extension Video: Equatable {
  static func == (lhs: Video, rhs: Video) -> Bool {
    lhs.sessionID == rhs.sessionID
  }
}

extension Video {
  var url: URL? {
    URL(string: urlString)
  }
}
