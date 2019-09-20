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
  
  // MARK: Init
  
  private let videos: [VideoViewModel]
  init(videos: [VideoViewModel], stateObserving: ObserveState? = nil) {
    self.videos = videos
    self.observe(stateObserving)
  }
  
  // MARK: Private
  
  private var observeCurrentVideo: ((VideoViewModel) -> Void)?
  
  private func observe(_ stateObserving: ObserveState?) {
    if case let .currentVideo(action) = stateObserving {
      observeCurrentVideo = action
    }
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
  
  var allPlatforms: [String] {
    Platform.allCases
      .map { $0.rawValue }
      .map { $0 == "all" ? $0.capitalized : $0 }
  }
  var weekday: [String] {
    WeekDay.allCases.map({ $0.rawValue })
  }
  func videoGroup(by day: String) -> [VideoViewModel] {
    videos
      .filter({ $0.weekday.rawValue == day })
      .filter({ !showFavoriteOnly ? true : $0.isFavorite })
      .filter({ specificPlatforms == "All" ? true : $0.platforms.contains(specificPlatforms) })
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
}
