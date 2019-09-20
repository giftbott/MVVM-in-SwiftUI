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
  
  // MARK: Init

  @Published private var video: Video
  
  init(video: Video) {
    self.video = video
  }
  
  
  // MARK: UI <- ViewModel  (1-way Data Binding)
  
  @Published var isSelected: Bool = false
    
  var id: Int {
    video.sessionID
  }
  var title: String {
    video.title
  }
  var duration: String {
    let hours = (video.duration / 3600)
    let minutes = (video.duration - (hours * 3600)) / 60
    let seconds = video.duration - (hours * 3600) - (minutes * 60)
    return String(format: "%2d:%02d:%02d", hours, minutes, seconds)
  }
  var weekday: WeekDay {
    video.weekDay
  }
  var platforms: String {
    video.platforms
      .filter({ $0 != .all })
      .map({ $0.rawValue })
      .joined(separator: ", ")
  }
  var url: URL? {
    URL(string: video.urlString)
  }
  var isFavorite: Bool {
    video.isFavorite
  }
  
  
  // MARK: UI -> ViewModel  (Commands)
  
  func executeCommand(_ command: Commands) {
    switch command {
    case .toggleFavorite:
      video.isFavorite.toggle()
    }
  }
}



// MARK: - Equatable

extension VideoViewModel: Equatable {
  static func ==(lhs: VideoViewModel, rhs: VideoViewModel) -> Bool {
    lhs.id == rhs.id
  }
}
