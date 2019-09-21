//
//  VideoViewModel.swift
//  WWDCPlayer
//
//  Created by Giftbot on 2019/09/13.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import Foundation

final class VideoViewModel: ObservableObject, Identifiable {
  enum Commands {
    case toggleFavorite
  }
  

  // MARK: UI <- ViewModel  (1-way Data Binding)
  
  @Published var isSelected: Bool = false
    
  let id: Int
  let title: String
  let duration: String
  let weekday: String
  let platforms: String
  let url: URL?
  var isFavorite: Bool { video.isFavorite }
  
  
  // MARK: UI -> ViewModel  (Commands)
  
  func executeCommand(_ command: Commands) {
    switch command {
    case .toggleFavorite:
      video.isFavorite.toggle()
    }
  }
  
  
  // MARK: Private
  
  @Published private var video: Video
  
  
  // MARK: Init
  
  init(video: Video) {
    self.video = video
    
    self.id = video.sessionID
    self.title = video.title
    self.weekday = video.weekDay.rawValue
    self.url = URL(string: video.urlString)
    
    self.duration = {
      let hours = ($0 / 3600)
      let minutes = ($0 - (hours * 3600)) / 60
      let seconds = $0 - (hours * 3600) - (minutes * 60)
      return String(format: "%2d:%02d:%02d", hours, minutes, seconds)
    }(video.duration)
    
    self.platforms = video.platforms
        .filter({ $0 != .all })
        .map({ $0.rawValue })
        .joined(separator: ", ")
  }
}



// MARK: - Equatable

extension VideoViewModel: Equatable {
  static func ==(lhs: VideoViewModel, rhs: VideoViewModel) -> Bool {
    lhs.id == rhs.id
  }
}
