//
//  Video.swift
//  WWDCPlayer
//
//  Created by Giftbot on 2019/09/13.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import Foundation

struct Video {
  var sessionID: Int
  var title: String
  var duration: Int
  var weekDay: WeekDay
  var platforms: [Platform]
  var urlString: String
  var isFavorite = false
}
