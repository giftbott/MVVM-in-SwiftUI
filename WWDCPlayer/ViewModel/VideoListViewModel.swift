//
//  VideoListViewModel.swift
//  WWDCPlayer
//
//  Created by Giftbot on 2019/09/20.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import Foundation

final class VideoListViewModel: ObservableObject {
  enum ObserveState {
    case currentVideo((VideoViewModel) -> Void)
  }
  enum Commands {
    case selectVideo(VideoViewModel)
  }

  
  // MARK: UI <-> ViewModel  (2-way Data Binding)

  @Published var showFavoriteOnly: Bool = false
  @UserDefault(key: "specificPlatforms", defaultValue: "All") var specificPlatforms: String {
    didSet { objectWillChange.send() }
  }
  
  
  // MARK: UI <- ViewModel  (1-way Data Binding)
  
  @Published private(set) var currentVideo: VideoViewModel? {
    willSet {
      currentVideo?.isSelected.toggle()
      newValue?.isSelected.toggle()
    }
  }
  let allPlatforms: [String]
  let weekday: [String]
  
  func videoGroup(by day: String) -> [VideoViewModel] {
    videos
      .filter({ $0.weekday == day })
      .filter({ showFavoriteOnly ? $0.isFavorite : true })
      .filter({ specificPlatforms != "All" ? $0.platforms.contains(specificPlatforms) : true })
  }
  
  
  // MARK: UI -> ViewModel  (Commands)
  
  func executeCommand(_ command: Commands) {
    switch command {
    case .selectVideo(let video):
      guard currentVideo != video else { return }
      currentVideo = video
      observeCurrentVideo?(video)
    }
  }
  
  
  // MARK: Private
  
  private let videos: [VideoViewModel]
  private var observeCurrentVideo: ((VideoViewModel) -> Void)?
  
  private func observe(_ stateObserving: ObserveState?) {
    if case let .currentVideo(action) = stateObserving {
      observeCurrentVideo = action
    }
  }
  
  // MARK: Init
  
  init(videos: [VideoViewModel], stateObserving: ObserveState? = nil) {
    self.videos = videos

    self.weekday = WeekDay.allCases.map({ $0.rawValue })
    self.allPlatforms = Platform.allCases
      .map { $0.rawValue }
      .map { $0 == "all" ? $0.capitalized : $0 }
    
    self.observe(stateObserving)
  }
}
